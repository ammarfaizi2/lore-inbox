Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264215AbRF1TeK>; Thu, 28 Jun 2001 15:34:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264103AbRF1Tdu>; Thu, 28 Jun 2001 15:33:50 -0400
Received: from ns.guardiandigital.com ([209.11.107.5]:62990 "HELO
	juggernaut.dmz.guardiandigital.com") by vger.kernel.org with SMTP
	id <S264039AbRF1Tdt>; Thu, 28 Jun 2001 15:33:49 -0400
Date: Thu, 28 Jun 2001 15:33:47 -0400 (EDT)
From: "Ryan W. Maple" <ryan@guardiandigital.com>
To: james bond <difda@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: BIG PROBLEM
In-Reply-To: <E15Fh8J-0007Sz-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.10.10106281532110.10868-100000@mastermind.inside.guardiandigital.com>
X-Base: ALL YOUR BASE ARE BELONG TO US. (http://www.scene.org/redhound/AYB.swf)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 28 Jun 2001, Alan Cox wrote:

> > i've  compiled the kernel 2.4.4 , once i finish and boot the first time on 
> > 2.4.4 everything goses ok ,
> > only too problemes
> > 1st-  klogd takes 100%  CPU time
> 
> Old old versions of klogd had bugs where they would do that. If there is
> a continuous problem it may also do so - does 'dmesg' show anything ?

I don't think it's limited to "old old" versions.  Version 1.3 would hit
100% CPU (DoS-style) when it received NULL bytes IIRC.

  http://lists.jammed.com/owl-users/2001/05/0000.html

>From what I remember, this happened with some of the 3com ethernet drivers
(the NULL bytes).  Maybe this is his problem wrt klogd...

Ryan

 +-- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --+
   Ryan W. Maple          "I dunno, I dream in Perl sometimes..."  -LW
   Guardian Digital, Inc.                     ryan@guardiandigital.com
 +-- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --+


