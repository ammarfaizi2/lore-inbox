Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314266AbSEITuX>; Thu, 9 May 2002 15:50:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314280AbSEITuW>; Thu, 9 May 2002 15:50:22 -0400
Received: from sparrow.ists.dartmouth.edu ([129.170.249.49]:21641 "EHLO
	sparrow.websense.net") by vger.kernel.org with ESMTP
	id <S314266AbSEITuV>; Thu, 9 May 2002 15:50:21 -0400
Date: Thu, 9 May 2002 15:50:05 -0400 (EDT)
From: William Stearns <wstearns@pobox.com>
X-X-Sender: wstearns@sparrow.websense.net
Reply-To: William Stearns <wstearns@pobox.com>
To: ML-linux-kernel <linux-kernel@vger.kernel.org>
cc: Jeff Dike <jdike@karaya.com>, William Stearns <wstearns@pobox.com>,
        George Bakos <gbakos@ists.dartmouth.edu>
Subject: pty logging patch
Message-ID: <Pine.LNX.4.44.0205091534210.2626-100000@sparrow.websense.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Good day, all,
	As part of a project that needs to log all keystrokes and screen 
output traveling over a pty, we have produced a patch to the stock linux 
kernel that does so.  It is designed to function in a UML environment to 
allow logging UML sessions out to the host.
	Please understand, we _do_ _not_ consider this, at _any_ level, to 
be appropriate for including in _any_ kernel tree.  We are providing it 
here to satisfy our requirements under the GPL and for those who might be 
interested.  Any arguments that this is too ugly to live will be met with 
vehement agreement.  :-)
	The permanent location for the patch is:  
http://www.stearns.org/patches/ .  The current name is 
2.4.19-uml-logging-patch .
	The work was accomplished by a well known UML kernel programmer 
who would prefer to not be associated with such a hack.  :-)  It is 
Copyright 2002 <jdike@karaya.com> and was funded by the Institute for 
Security Technology Studies.
	Cheers,
	- Bill

---------------------------------------------------------------------------
	"A raccoon tangled with a 23,000 volt line today.  The results
blacked out 1400 homes and, of course, one raccoon."
	-- Steel City News
	Courtesy of G.W. Wettstein <greg@wind.enjellic.com>
--------------------------------------------------------------------------
William Stearns (wstearns@pobox.com).  Mason, Buildkernel, named2hosts, 
and ipfwadm2ipchains are at:                        http://www.stearns.org
--------------------------------------------------------------------------

