Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266917AbRHAMdc>; Wed, 1 Aug 2001 08:33:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266919AbRHAMdV>; Wed, 1 Aug 2001 08:33:21 -0400
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:58577 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S266917AbRHAMdJ>; Wed, 1 Aug 2001 08:33:09 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Roger Abrahamsson <hyperion@gnyrf.net>
Date: Wed, 1 Aug 2001 22:33:04 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15207.63232.611617.37794@notabene.cse.unsw.edu.au>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: resizing of raid5?
In-Reply-To: message from Roger Abrahamsson on Wednesday August 1
In-Reply-To: <996657922.3b67cb02ba717@stargate.gnyrf.net>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday August 1, hyperion@gnyrf.net wrote:
> Hello.
> 
> Just figured if anyone could give some information about resizing of software
> raid5 systems (2.4.x kernels)? I've been looking all over for information about
> if this is possible or not currently, and if not, how this system of raid
> cluster blocks work in conjunction with ext2. The code is a bit tricky and not
> too many comments to help one try and get a hold of how it works.
> Any pointers for this would be nice.

The only way to resize a raid5 array is to back up, rebuild, and
re-load.  Any attempt to re-organise the data, or the linkage, to
avoid this would be more trouble that it is worth.

NeilBrown
