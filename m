Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269651AbRIUHHK>; Fri, 21 Sep 2001 03:07:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271697AbRIUHHA>; Fri, 21 Sep 2001 03:07:00 -0400
Received: from gatekeeper-s.gts.cz ([194.213.203.154]:32503 "HELO
	mail.idoox.com") by vger.kernel.org with SMTP id <S269651AbRIUHG4>;
	Fri, 21 Sep 2001 03:06:56 -0400
Date: Fri, 21 Sep 2001 09:07:20 +0200
From: David Hajek <david@atrey.karlin.mff.cuni.cz>
To: linux-kernel@vger.kernel.org
Subject: Re: high cpu load with sw raid1
Message-ID: <20010921090720.A12970@pida.ulita.cz>
Reply-To: david@atrey.karlin.mff.cuni.cz
In-Reply-To: <20010920102616.A2753@pida.ulita.cz> <20010920124020.D14526@turbolinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010920124020.D14526@turbolinux.com>; from adilger@turbolabs.com on Thu, Sep 20, 2001 at 12:40:20PM -0600
X-Operating-System: Linux 2.2.19
Organization: IDOOX.COM
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 20, 2001, Andreas Dilger wrote:
> On Sep 20, 2001  10:26 +0200, David Hajek wrote:
> > I have linux box with 70GB SW Raid1. This box runs for half
> > a year without problems but now I meet the high cpu load 
> > problems. I suspect that it can be caused by not enough 
> > free disk space on this md device. I see following:
> > 
> > 1 GB free  - load > 5
> > 5 GB free  - load < 1
> 
> What filesystem are you using?  If it is reiserfs, and you have < 10%
> of the disk free, it is very unhappy.  A patch to fix this is available.
> 

I'm using ext2. I suspect high ext2 fragmentation, because when
there are 'only' 1GB free the disk is _really_ busy. I doubt
that it takes lot of time to find free blocks. 

-- 
David Hajek
hajek@idoox.com                	     GSM: +420 604 352968
- VMS is like a nightmare about RXS-11M.

