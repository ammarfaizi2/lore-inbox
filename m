Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262128AbSJKLEz>; Fri, 11 Oct 2002 07:04:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262397AbSJKLEy>; Fri, 11 Oct 2002 07:04:54 -0400
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:31197 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S262128AbSJKLEy>; Fri, 11 Oct 2002 07:04:54 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Falk Brockerhoff <falk@brockerhoff.org>
Date: Fri, 11 Oct 2002 21:10:24 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15782.45472.274280.749816@notabene.cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Software-Raid: mark non-fresh disk as clean?
In-Reply-To: message from Falk Brockerhoff on  October 11
References: <1034334523.2361.15.camel@fairlight>
X-Mailer: VM 7.07 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  October 11, falk@brockerhoff.org wrote:
> Hello,
> 
> i have a problem with my raid-array. I hope I'm at the right place (here
> in this list) and that you can help me.
> 
> I've a simple question: how can I mark the "non-fresh" disks /dev/hde1
> and /dev/hdg1 as "clean"? I didn't found anything at the web or in the
> list archive. I'm using kernel 2.4.18 with builtin software-raid
> support.

Get mdadm and use

   mdadm --assemble --force /dev/md0 /dev/hdk1 /dev/hdi1 /dev/hdg1  /dev/hde1


http://www.cse.unsw.edu.au/source/mdadm/

NeilBrown
