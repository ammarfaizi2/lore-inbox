Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031631AbWLEVeV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031631AbWLEVeV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 16:34:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031630AbWLEVeV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 16:34:21 -0500
Received: from mailer.gwdg.de ([134.76.10.26]:41269 "EHLO mailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1031627AbWLEVeU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 16:34:20 -0500
Date: Tue, 5 Dec 2006 22:27:10 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: "Josef 'Jeff' Sipek" <jsipek@cs.sunysb.edu>
cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, akpm@osdl.org,
       hch@infradead.org, viro@ftp.linux.org.uk, linux-fsdevel@vger.kernel.org,
       mhalcrow@us.ibm.com
Subject: Re: [PATCH 21/35] Unionfs: Inode operations
In-Reply-To: <11652354711835-git-send-email-jsipek@cs.sunysb.edu>
Message-ID: <Pine.LNX.4.61.0612052222190.18570@yvahk01.tjqt.qr>
References: <1165235468365-git-send-email-jsipek@cs.sunysb.edu>
 <11652354711835-git-send-email-jsipek@cs.sunysb.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Dec 4 2006 07:30, Josef 'Jeff' Sipek wrote:
>+	if (!hidden_dentry) {
>+		/* if hidden_dentry is NULL, create the entire
>+		 * dentry directory structure in branch 'bindex'.
>+		 * hidden_dentry will NOT be null when bindex == bstart
>+		 * because lookup passed as a negative unionfs dentry
>+		 * pointing to a lone negative underlying dentry */
>+		hidden_dentry = create_parents(parent, dentry, bindex);

Someone refresh me: what's the correct[preferred] kdoc style?

(A)
	/* Lorem ipsum dolor sit amet, consectetur
	 * adipisicing elit, sed do eiusmod tempor
	 * incididunt ut labore et dolore magna aliqua. */

(B)
	/* Lorem ipsum dolor sit amet, consectetur
	   adipisicing elit, sed do eiusmod tempor
	   incididunt ut labore et dolore magna aliqua. */

(C)
	/* Lorem ipsum dolor sit amet, consectetur
	adipisicing elit, sed do eiusmod tempor incididunt
	ut labore et dolore magna aliqua. */


	-`J'
-- 
