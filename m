Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267225AbSKPFyw>; Sat, 16 Nov 2002 00:54:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267226AbSKPFyv>; Sat, 16 Nov 2002 00:54:51 -0500
Received: from excalibur.cc.purdue.edu ([128.210.189.22]:44045 "EHLO
	ibm-ps850.purdueriots.com") by vger.kernel.org with ESMTP
	id <S267225AbSKPFyu>; Sat, 16 Nov 2002 00:54:50 -0500
Date: Sat, 16 Nov 2002 01:04:35 -0500 (EST)
From: Patrick Finnegan <pat@purdueriots.com>
To: Jeff Garzik <jgarzik@pobox.com>
cc: Dan Kegel <dank@kegel.com>, john slee <indigoid@higherplane.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Why can't Johnny compile?
In-Reply-To: <3DD5DC77.2010406@pobox.com>
Message-ID: <Pine.LNX.4.44.0211160059540.16668-100000@ibm-ps850.purdueriots.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Nov 2002, Jeff Garzik wrote:

> Most of the stuff that doesn't compile (or link) is typically stuff that
> is lesser used, or never used.  A lot of the don't-compile complaints
> seem to be vocal-minority type complaints or "why can't I build _every_
> module in the kernel?" complaints.  Ref allmodconfig, above.
>
> If people want to get rivafb or an ancient ISA net driver building
> again... patches welcome.  But I don't think calls for the kernel to
> compile 100 percent of the drivers is realistic or even reasonable.
> Some of the APIs, particularly SCSI, are undergoing API stabilization.
> And SCSI is an excellent example of drivers where
> I-dont-have-test-hardware patches to fix compilation may miss subtle
> problems -- and then six months later when the compileable-but-broken
> SCSI driver is used by a real user, we have to spend more time in the
> long run tracking down the problem.

Wouldn't it then seem reasonable to remove things from the kernel that
have been broken for a long time, and no one seems to care enough to fix?
I know of at least one driver (IOmega Buz v4l) that seems to have fallen
into disrepair possibly since before 2.4.0, and as far as I know has not
been repaired since then.

Pat
--
Purdue Universtiy ITAP/RCS
Information Technology at Purdue
Research Computing and Storage
http://www-rcd.cc.purdue.edu


