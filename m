Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318329AbSGYL7t>; Thu, 25 Jul 2002 07:59:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318349AbSGYL7t>; Thu, 25 Jul 2002 07:59:49 -0400
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:27303 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S318329AbSGYL7s>; Thu, 25 Jul 2002 07:59:48 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Date: Thu, 25 Jul 2002 22:03:02 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15679.59638.455968.667000@notabene.cse.unsw.edu.au>
Cc: Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: RAID problems
In-Reply-To: message from Roy Sigurd Karlsbakk on Thursday July 25
References: <200207251354.04229.roy@karlsbakk.net>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday July 25, roy@karlsbakk.net wrote:
> hi all
> 
> What is there to do when the following happens:
> 
> a 16 drive RAID fails, giving me an error message telling 4 drives have gone 
> dead. In fact only one has.
> 
> How can I hack the superblock on the reminding disks to bring them "up", so 
> the kernel can start using the spare?

Get mdadm
   http://www.cse.unsw.edu.au/~neilb/source/mdadm/

read man page, particular in reference to --assemble with --force

Use mdadm to re-assemble the array.

NeilBrown
