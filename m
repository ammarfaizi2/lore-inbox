Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261731AbTCHBig>; Fri, 7 Mar 2003 20:38:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261970AbTCHBig>; Fri, 7 Mar 2003 20:38:36 -0500
Received: from hera.cwi.nl ([192.16.191.8]:3026 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S261731AbTCHBif>;
	Fri, 7 Mar 2003 20:38:35 -0500
From: Andries.Brouwer@cwi.nl
Date: Sat, 8 Mar 2003 02:49:08 +0100 (MET)
Message-Id: <UTC200303080149.h281n8D09209.aeb@smtp.cwi.nl>
To: Andries.Brouwer@cwi.nl, greg@kroah.com
Subject: Re: [PATCH] register_blkdev
Cc: akpm@digeo.com, alan@lxorguk.ukuu.org.uk, hch@infradead.org,
       linux-kernel@vger.kernel.org, torvalds@transmeta.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> register_chrdev() only allocates based on a major

Yes.

[Silly enough. The entire business of registration does not
depend at all on whether one is a character or a block device.
I am really unhappy with the fact that the completely uniform
code that we used to have now has been split into two rather
separate pieces of code.]

But you are quite right that an audit is needed.

[I think I described the amount of work as: two hours to make
the patches, a weekend to do the audit.]

Andries
