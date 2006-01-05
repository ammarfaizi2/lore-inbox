Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752146AbWAETT7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752146AbWAETT7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 14:19:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752131AbWAETT7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 14:19:59 -0500
Received: from hera.kernel.org ([140.211.167.34]:9957 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1752146AbWAETT6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 14:19:58 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [2.6 patch] Define BITS_PER_BYTE
Date: Thu, 5 Jan 2006 11:19:35 -0800 (PST)
Organization: Mostly alphabetical, except Q, with we do not fancy
Message-ID: <dpjrg7$cvr$1@terminus.zytor.com>
References: <20051108185349.6e86cec3.akpm@osdl.org> <20060104232442.GX3831@stusta.de> <Pine.LNX.4.61.0601050802590.10161@yvahk01.tjqt.qr> <1136474301.31922.1.camel@serpentine.pathscale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1136488775 13308 127.0.0.1 (5 Jan 2006 19:19:35 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Thu, 5 Jan 2006 19:19:35 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <1136474301.31922.1.camel@serpentine.pathscale.com>
By author:    "Bryan O'Sullivan" <bos@pathscale.com>
In newsgroup: linux.dev.kernel
>
> On Thu, 2006-01-05 at 08:03 +0100, Jan Engelhardt wrote:
> 
> > Oh no :( This sounds as uncommon as CHAR_BIT in C.
> 
> CHAR_BIT is completely unclear.  BITS_PER_BYTE is self-evident, and
> makes it a lot more obvious when you're doing arithmetic that involves
> counting bits.
> 

Tough cookies.  The standard name for this define is CHAR_BIT, and
anyone who doesn't know that "char" means byte in C doesn't know the C
language.  "char" certainly doesn't mean "character" in this day of
UTF-8 and friends.

	-hpa

