Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278079AbRJPDon>; Mon, 15 Oct 2001 23:44:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278080AbRJPDo0>; Mon, 15 Oct 2001 23:44:26 -0400
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:5577 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S278079AbRJPDoM>; Mon, 15 Oct 2001 23:44:12 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Mark Hahn <hahn@physics.mcmaster.ca>
Date: Tue, 16 Oct 2001 13:44:39 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15307.44327.541413.250400@notabene.cse.unsw.edu.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: very slow RAID-1 resync
In-Reply-To: message from Mark Hahn on Monday October 15
In-Reply-To: <Pine.LNX.4.33.0110151653120.13462-100000@windmill.gghcwest.com>
	<Pine.LNX.4.10.10110152156570.25210-100000@coffee.psychology.mcmaster.ca>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday October 15, hahn@physics.mcmaster.ca wrote:
> > raid1d and raid1syncd are barely getting any CPU time on this otherwise
> > idle SMP system.
> 
> I noticed this too, on a uni, raid5 system;
> the resync-throttling code doesn't seem to work well.

It works great for me...
What sort of drives do you have? SCSI? IDE? are you using both master
and slave on an IDE controller?

NeilBrown

