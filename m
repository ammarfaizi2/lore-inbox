Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965076AbWECC6D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965076AbWECC6D (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 22:58:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965077AbWECC6D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 22:58:03 -0400
Received: from hera.kernel.org ([140.211.167.34]:7896 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S965076AbWECC6C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 22:58:02 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Too many levels of symbolic links
Date: Tue, 2 May 2006 19:57:34 -0700 (PDT)
Organization: Mostly alphabetical, except Q, with we do not fancy
Message-ID: <e3966u$dje$1@terminus.zytor.com>
References: <14CFC56C96D8554AA0B8969DB825FEA0012B309B@chicken.machinevisionproducts.com> <44580CF2.7070602@tlinx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1146625054 13935 127.0.0.1 (3 May 2006 02:57:34 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Wed, 3 May 2006 02:57:34 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <44580CF2.7070602@tlinx.org>
By author:    Linda Walsh <lkml@tlinx.org>
In newsgroup: linux.dev.kernel
> Is this what you are looking for?
> include/linux/namei.h    MAX_NESTED_LINKS = 5
> (used in fs/namei.c, where comment claims MAX_NESTING is equal to 8)

Wonder if it would make sense to make this a sysctl...

	-hpa
