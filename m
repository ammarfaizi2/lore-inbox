Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267300AbTAKQ7w>; Sat, 11 Jan 2003 11:59:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267306AbTAKQ7v>; Sat, 11 Jan 2003 11:59:51 -0500
Received: from host194.steeleye.com ([66.206.164.34]:4617 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S267300AbTAKQ7v>; Sat, 11 Jan 2003 11:59:51 -0500
Message-Id: <200301111708.h0BH8Mk03240@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: Rusty Russell <rusty@rustcorp.com.au>
cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org, akpm@zip.com.au,
       Thomas Sailer <sailer@ife.ee.ethz.ch>,
       Jose Orlando Pereira <jop@di.uminho.pt>,
       J.E.J.Bottomley@HansenPartnership.com,
       Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] Remove exec_usermodehelper 
In-Reply-To: Message from Rusty Russell <rusty@rustcorp.com.au> 
   of "Sat, 11 Jan 2003 19:03:15 +1100." <20030111100327.863E92C0BC@lists.samba.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 11 Jan 2003 12:08:22 -0500
From: James Bottomley <James.Bottomley@steeleye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

rusty@rustcorp.com.au said:
> Updated for 2.5.56, and retested (dumb compile error fixed).  No word
> from James, but Marcel and Thomas gave it the thumbs up. 

Sorry, I'm currently on a business trip.  I finally found a voyager system 
around here to test it on and it seems to work (at least for machine shutdown 
on panel switch).  I can't test the internal battery (of all the Voyagers in 
the junk heap around here---where NCR manufactured them---none has an internal 
battery).

Go ahead and apply it.  I probably need to migrate the voyager machine state 
handling to use kevents anyway, but I'll do that later.

James


