Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759988AbWLFENE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759988AbWLFENE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 23:13:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759963AbWLFEND
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 23:13:03 -0500
Received: from rgminet01.oracle.com ([148.87.113.118]:20763 "EHLO
	rgminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759988AbWLFENA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 23:13:00 -0500
Date: Tue, 5 Dec 2006 20:12:41 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       "Josef 'Jeff' Sipek" <jsipek@cs.sunysb.edu>,
       linux-kernel@vger.kernel.org, torvalds@osdl.org, hch@infradead.org,
       viro@ftp.linux.org.uk, linux-fsdevel@vger.kernel.org,
       mhalcrow@us.ibm.com
Subject: Re: [PATCH 21/35] Unionfs: Inode operations
Message-Id: <20061205201241.55c1dd9f.randy.dunlap@oracle.com>
In-Reply-To: <20061205135017.3be94142.akpm@osdl.org>
References: <1165235468365-git-send-email-jsipek@cs.sunysb.edu>
	<11652354711835-git-send-email-jsipek@cs.sunysb.edu>
	<Pine.LNX.4.61.0612052222190.18570@yvahk01.tjqt.qr>
	<20061205135017.3be94142.akpm@osdl.org>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Dec 2006 13:50:17 -0800 Andrew Morton wrote:

> On Tue, 5 Dec 2006 22:27:10 +0100 (MET)
> Jan Engelhardt <jengelh@linux01.gwdg.de> wrote:
> 
> > Someone refresh me: what's the correct[preferred] kdoc style?
> 
> This isn't part of kernel-doc, if that's what you mean.
> 
> > (A)
> > 	/* Lorem ipsum dolor sit amet, consectetur
> > 	 * adipisicing elit, sed do eiusmod tempor
> > 	 * incididunt ut labore et dolore magna aliqua. */
> > 
> > (B)
> > 	/* Lorem ipsum dolor sit amet, consectetur
> > 	   adipisicing elit, sed do eiusmod tempor
> > 	   incididunt ut labore et dolore magna aliqua. */
> > 
> > (C)
> > 	/* Lorem ipsum dolor sit amet, consectetur
> > 	adipisicing elit, sed do eiusmod tempor incididunt
> > 	ut labore et dolore magna aliqua. */
> 
> You forgot (D), (E), (F), (G) and a whole lot more besides.
> 
> It doesn't matter a lot what we do, but we should do it one way and not 38
> ways.
> 
> Documentation/CodingStyle doesn't mention commenting at all (eyes roll
> heavenwards).

I have several (probably 5-6) Doc/CodingStyle changes in my WIP
(work-in-progress) folder that I will do in the next few days.



> This
> 
> 	/*
> 	 * Lorem ipsum dolor sit amet, consectetur
> 	 * adipisicing elit, sed do eiusmod tempor
> 	 * incididunt ut labore et dolore magna aliqua.
> 	 */
> 
> is probably the most common, and is what I use when forced to descrog
> comments.

---
~Randy
