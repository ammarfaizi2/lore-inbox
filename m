Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277782AbRKAEM1>; Wed, 31 Oct 2001 23:12:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277791AbRKAEMI>; Wed, 31 Oct 2001 23:12:08 -0500
Received: from ares.sot.com ([195.74.13.236]:50704 "EHLO ares.sot.com")
	by vger.kernel.org with ESMTP id <S277782AbRKAEMG>;
	Wed, 31 Oct 2001 23:12:06 -0500
Date: Thu, 1 Nov 2001 06:12:41 +0200 (EET)
From: Yaroslav Popovitch <yp@sot.com>
To: Joachim Backes <backes@rhrk.uni-kl.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: kernel 2.4.12: Missing tty when logging in on the console
Message-ID: <Pine.LNX.4.10.10111010601190.22300-100000@ares.sot.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Was it fixed?
And where find this fix..


Cheers,YP

###########################################################
after installation of kernel 2.4.12 (migrated from 2.4.10
by "make oldconfig"), having problems when logging in on
a virtual console:

It sems that there is no correct tty attached to the console:

1. the ps command lists _all_ processes actually running under
   the correspondent userid and only those running under
   the login shell.

2. Starting a ssh command for some other box is rejected
   by

                You have no controlling tty and no DISPLAY.
                Cannot read passphrase.

I never had such problems when running 2.4.10 kernel.



