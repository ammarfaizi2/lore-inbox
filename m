Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311575AbSDKQfV>; Thu, 11 Apr 2002 12:35:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311879AbSDKQfU>; Thu, 11 Apr 2002 12:35:20 -0400
Received: from host194.steeleye.com ([216.33.1.194]:24327 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S311575AbSDKQfU>; Thu, 11 Apr 2002 12:35:20 -0400
Message-Id: <200204111635.g3BGZCb02271@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: "Alexis S. L. Carvalho" <alexis@cecm.usp.br>
cc: linux-kernel@vger.kernel.org, James.Bottomley@SteelEye.com
Subject: Re: implementing soft-updates
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 11 Apr 2002 11:35:11 -0500
From: James Bottomley <James.Bottomley@SteelEye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

support@steeleye.com said:
> Does anyone know of any implementation of soft-updates over ext2? I'm
> starting a project on this for grad school, and I'd like to know of
> any previous (current?) efforts.

There was a previous attempt (now defunct, I believe) to implement a phase 
tree approach for ext2.  While this is definitely not the same as the McKusik 
soft update approach, the end goal of ensuring that the filesystem is 
consistent at all times during operation is, so you may be able to salvage 
something to help you from it.

The person originally doing it was Daniel Phillips

http://people.nl.linux.org/~phillips/

and he called the filesystem tux2.  There were also several papers he 
presented, one to ALS 2000 which unfortunately has no surviving on-line copy.  
Marc Merlin I believe has a copy of the presentation made to the Australian 
Linux Conference in 2001:

http://marc.merlins.org/linux/linux.conf.au_2001/Day2/Tux2.html

And there are probably others dotted about the web if you look.

James Bottomley


