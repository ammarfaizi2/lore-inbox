Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274602AbRITSk4>; Thu, 20 Sep 2001 14:40:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274604AbRITSkq>; Thu, 20 Sep 2001 14:40:46 -0400
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:25341 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S274602AbRITSkf>; Thu, 20 Sep 2001 14:40:35 -0400
From: Andreas Dilger <adilger@turbolabs.com>
Date: Thu, 20 Sep 2001 12:40:20 -0600
To: David Hajek <david@atrey.karlin.mff.cuni.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: high cpu load with sw raid1
Message-ID: <20010920124020.D14526@turbolinux.com>
Mail-Followup-To: David Hajek <david@atrey.karlin.mff.cuni.cz>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010920102616.A2753@pida.ulita.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010920102616.A2753@pida.ulita.cz>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 20, 2001  10:26 +0200, David Hajek wrote:
> I have linux box with 70GB SW Raid1. This box runs for half
> a year without problems but now I meet the high cpu load 
> problems. I suspect that it can be caused by not enough 
> free disk space on this md device. I see following:
> 
> 1 GB free  - load > 5
> 5 GB free  - load < 1

What filesystem are you using?  If it is reiserfs, and you have < 10%
of the disk free, it is very unhappy.  A patch to fix this is available.

Cheers, Andreas
--
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert

