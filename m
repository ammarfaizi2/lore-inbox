Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262730AbSJ0Wwa>; Sun, 27 Oct 2002 17:52:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262722AbSJ0Ww3>; Sun, 27 Oct 2002 17:52:29 -0500
Received: from c16410.randw1.nsw.optusnet.com.au ([210.49.25.29]:16115 "EHLO
	mail.chubb.wattle.id.au") by vger.kernel.org with ESMTP
	id <S262730AbSJ0Wvt>; Sun, 27 Oct 2002 17:51:49 -0500
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15804.28536.3553.712306@wombat.chubb.wattle.id.au>
Date: Mon, 28 Oct 2002 09:58:00 +1100
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Patrick Mochel <mochel@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: Switching from IOCTLs to a RAMFS
In-Reply-To: <717068543@toto.iv>
X-Mailer: VM 7.04 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Comments: Hyperbole mail buttons accepted, v04.18.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Jeff" == Jeff Garzik <jgarzik@pobox.com> writes:


Jeff> Like I touched on in IRC, there is room for both sysfs and per-driver 
Jeff> filesystems.

Jeff> I think just about everyone agrees that ioctls are a bad idea and a huge 
Jeff> maintenance annoyance.  

I note that the P1003.26 ballot has just been announced...

  Title: P1003.26:  Information Technology -- Portable Operating  
  System Interface (POSIX) -- Part 26:  Device Control  
  Application Program Interface (API) [C Language] 
 
  Scope: This work will define an application program interface to  
  device drivers.  The interface will be modeled on the  
  traditional ioctl() function, but will have enhancements  
  designed to address issues such as "type safety" and  
  reentrancy. 
 

It may be worth looking at what the draft standard says before
committing to yet another interface specification.

Peter C
