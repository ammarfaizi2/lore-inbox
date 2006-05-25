Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964776AbWEYAav@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964776AbWEYAav (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 20:30:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964791AbWEYAav
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 20:30:51 -0400
Received: from hera.kernel.org ([140.211.167.34]:44985 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S964776AbWEYAau (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 20:30:50 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Query regarding _etext, _edata, _end.
Date: Wed, 24 May 2006 17:30:24 -0700 (PDT)
Organization: Mostly alphabetical, except Q, with we do not fancy
Message-ID: <e52tr0$6jt$1@terminus.zytor.com>
References: <3faf05680605231804q5aa8d65fqeb02026dd1515876@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1148517024 6782 127.0.0.1 (25 May 2006 00:30:24 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Thu, 25 May 2006 00:30:24 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <3faf05680605231804q5aa8d65fqeb02026dd1515876@mail.gmail.com>
By author:    "vamsi krishna" <vamsi.krishnak@gmail.com>
In newsgroup: linux.dev.kernel
>
> Hello All,
> 
> Are the virtual address's &_etext, &_edata and &_end , always
> correspond to END OF TEXT, END OF DATA and END OF BSS ?
> 
> If yes , will these be always supported in the newer kernels coming in future?
> 

That's a feature of the linker, not of the kernel.

I don't think they'll go away, but they may not be supported on all platforms.

	-ha
