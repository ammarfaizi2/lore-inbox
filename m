Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267028AbSLQWsH>; Tue, 17 Dec 2002 17:48:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267029AbSLQWsH>; Tue, 17 Dec 2002 17:48:07 -0500
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:42446 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S267028AbSLQWsG>; Tue, 17 Dec 2002 17:48:06 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Anu <avaidya@unity.ncsu.edu>
Date: Wed, 18 Dec 2002 09:55:45 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15871.43889.537411.835220@notabene.cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: detecting layout in RAID
In-Reply-To: message from Anu on Thursday December 12
References: <20021211183059.A19030@light-brigade.mit.edu>
	<Pine.GSO.4.44.0212121507430.3980-100000@sun.cesr.ncsu.edu>
X-Mailer: VM 7.07 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday December 12, avaidya@unity.ncsu.edu wrote:
> hello,
> 	I am trying to detect layouts of the RAID configuration (I have a
> software RAID set up. ) Mine is currently left symmetric and the way I am
> trying to detect layout is to reaad consecutive blocks and look for
> whether there is a big dp when it has to move all the way across..

What exactly do you mean by "move all the way across"?
The only things that move are the drive which spins and the heads
which move back and forth.

I suspect that the way to detect differences in layout is to do lots
of random reads of different block sizes and look for different
throughput. 

NeilBrown
