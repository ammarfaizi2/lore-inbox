Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262158AbUKKBwR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262158AbUKKBwR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 20:52:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262160AbUKKBwR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 20:52:17 -0500
Received: from hera.kernel.org ([63.209.29.2]:14765 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S262158AbUKKBwO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 20:52:14 -0500
To: linux-kernel@vger.kernel.org
From: hpa@zytor.com (H. Peter Anvin)
Subject: Re: 2.6.10-rc1-mm3
Date: Thu, 11 Nov 2004 01:52:08 +0000 (UTC)
Organization: Mostly alphabetical, except Q, which We do not fancy
Message-ID: <cmugk8$r4v$1@terminus.zytor.com>
References: <9dda349204110611043e093bca@mail.gmail.com> <20041108224259.GA14506@kroah.com> <20041108212747.33b6e14a.akpm@osdl.org> <20041109103354.GA14497@apps.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1100137928 27808 127.0.0.1 (11 Nov 2004 01:52:08 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Thu, 11 Nov 2004 01:52:08 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20041109103354.GA14497@apps.cwi.nl>
By author:    Andries Brouwer <Andries.Brouwer@cwi.nl>
In newsgroup: linux.dev.kernel
> 
> I would be inclined to remove the variable CONFIG_LEGACY_PTY_COUNT,
> using 256. If one really wants to use CONFIG_LEGACY_PTYS, that is
> the right number. So, in include/linux/tty.h:
> 
> - #define NR_PTYS CONFIG_LEGACY_PTY_COUNT
> + #define NR_PTYS 256
> 

Embedded people want to be able to set it to fewer.  Not all of them
can dispose of them entirely, but may not need 256.

	-hpa
