Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264959AbRGEMNm>; Thu, 5 Jul 2001 08:13:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264968AbRGEMNc>; Thu, 5 Jul 2001 08:13:32 -0400
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:4996 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S264959AbRGEMNQ>; Thu, 5 Jul 2001 08:13:16 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Peter Zaitsev <pz@spylog.ru>
Date: Thu, 5 Jul 2001 22:13:00 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15172.22988.643481.421716@notabene.cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Is  Swapping on software RAID1 possible  in linux 2.4 ?
In-Reply-To: message from Peter Zaitsev on Thursday July 5
In-Reply-To: <1011478953412.20010705152412@spylog.ru>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday July 5, pz@spylog.ru wrote:
> Hello linux-kernel,
> 
>   Does anyone have information on this subject ?  I have the constant
>   failures with system swapping on RAID1, I just wanted to be shure
>   this may be the problem or not.   It works without any problems with
>   2.2 kernel.

It certainly should work in 2.4.  What sort of "constant failures" are
you experiencing?

Though it does appear to work in 2.2, there is a possibility of data
corruption if you swap onto a raid1 array that is resyncing.  This
possibility does not exist in 2.4.

NeilBrown
