Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264788AbSKEIJM>; Tue, 5 Nov 2002 03:09:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264804AbSKEIJM>; Tue, 5 Nov 2002 03:09:12 -0500
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:14758 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S264803AbSKEIJL>; Tue, 5 Nov 2002 03:09:11 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: "H. Peter Anvin" <hpa@zytor.com>
Date: Tue, 5 Nov 2002 19:15:32 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15815.32292.689774.895238@notabene.cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Reconfiguring one SW-RAID when other RAIDs are running
In-Reply-To: message from H. Peter Anvin on Monday November 4
References: <3DC762FC.8070007@zytor.com>
X-Mailer: VM 7.07 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday November 4, hpa@zytor.com wrote:
> Hi all,
> 
> I'm trying to re-create a RAID while leaving the other RAIDs -- 
> including the root filesystem -- running, but mkraid refuses to run:
> 
> hera 1 # mkraid /dev/md2
> /dev/md0: array is active -- run raidstop first.
> mkraid: aborted.
> (In addition to the above messages, see the syslog and /proc/mdstat as well
>   for potential clues.)

I cannot offer any help on using mkraid, except to avoid it :-(
mdadm is (I believe and others agree) much easier to use.
  http://www.cse.unsw.edu.au/~neilb/source/mdadm/

It is definately being maintained, not that it has needed much...

> 
> (Also note: the raid directory on kernel.org seems to be abandoned. 
> Unless someone speaks up I'm going to remove it.)
> 

Again, I cannot comment on this directory, but would there be any
change of getting somewhere on kernel.org to distribute mdadm??

Thanks,
NeilBrown
