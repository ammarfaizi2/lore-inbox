Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278840AbRJZS5w>; Fri, 26 Oct 2001 14:57:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278842AbRJZS5n>; Fri, 26 Oct 2001 14:57:43 -0400
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:6387 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S278840AbRJZS51>; Fri, 26 Oct 2001 14:57:27 -0400
From: Andreas Dilger <adilger@turbolabs.com>
Date: Fri, 26 Oct 2001 12:52:54 -0600
To: Jeff Golds <jgolds@resilience.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Deadlock with linux kernel
Message-ID: <20011026125254.R23590@turbolinux.com>
Mail-Followup-To: Jeff Golds <jgolds@resilience.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <E15xB2K-0000oI-00@the-village.bc.nu> <3BD9AF2B.FC9D4977@resilience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3BD9AF2B.FC9D4977@resilience.com>
User-Agent: Mutt/1.3.22i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 26, 2001  11:44 -0700, Jeff Golds wrote:
> Alan Cox wrote:
> > > Also, I don't see any signs of a kernel Oops in the syslog, so that
> > > doesn't appear to be the problem.
> > 
> > Does the capslock key stil work when it locks up. I suspect you are seeing
> > a non VM related problem. The VM stuff has tended to be livelocks rather
> > than hung boxes.
> 
> Hmm, I haven't noticed.  I'll be sure to check that next time it occurs.

Please also try Ctrl-Alt-SysRq-P to see if you can get info about where it
is stuck.  You will need to pass the output through ksymoops for it to be
meaningful.

Cheers, Andreas
--
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert

