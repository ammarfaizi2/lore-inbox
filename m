Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263190AbUCMVTg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Mar 2004 16:19:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263191AbUCMVTg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Mar 2004 16:19:36 -0500
Received: from smtp814.mail.sc5.yahoo.com ([66.163.170.84]:57782 "HELO
	smtp814.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S263190AbUCMVTe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Mar 2004 16:19:34 -0500
From: tabris <tabris@tabris.net>
To: arjanv@redhat.com, Micha Feigin <michf@post.tau.ac.il>
Subject: Re: finding out the value of HZ from userspace
Date: Sat, 13 Mar 2004 16:19:00 -0500
User-Agent: KMail/1.5.3
Cc: lkml <linux-kernel@vger.kernel.org>
References: <20040311141703.GE3053@luna.mooo.com> <1079198671.4446.3.camel@laptop.fenrus.com>
In-Reply-To: <1079198671.4446.3.camel@laptop.fenrus.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403131619.00478.tabris@tabris.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 13 March 2004 12:24 pm, Arjan van de Ven wrote:
> On Thu, 2004-03-11 at 15:17, Micha Feigin wrote:
> > Is it possible to find out what the kernel's notion of HZ is from user
> > space?
> > It seem to change from system to system and between 2.4 (100 on i386)
> > to 2.6 (1000 on i386).
>
> if you can see 1000 from userspace that is a bad kernel bug; can you say
> where you find something in units of 1000 ?
2.6.3-rc1-mm1

procinfo gives the timer interrupt counting 1000 ints/sec
tho procinfo is broken for other stuff like 2.4 showed pages swapped, pages 
read in and out.

--
tabris
-
"We never make assertions, Miss Taggart," said Hugh Akston.  "That is
the moral crime peculiar to our enemies.  We do not tell -- we *show*.
We do not claim -- we *prove*."  
-- Ayn Rand, _Atlas Shrugged_

