Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268901AbRG0RaT>; Fri, 27 Jul 2001 13:30:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268904AbRG0RaL>; Fri, 27 Jul 2001 13:30:11 -0400
Received: from twilight.cs.hut.fi ([130.233.40.5]:47086 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S268901AbRG0R34>; Fri, 27 Jul 2001 13:29:56 -0400
Date: Fri, 27 Jul 2001 20:29:50 +0300
From: Ville Herva <vherva@mail.niksula.cs.hut.fi>
To: Kip Macy <kmacy@netapp.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, kernel <linux-kernel@vger.kernel.org>
Subject: Re: ReiserFS / 2.4.6 / Data Corruption
Message-ID: <20010727202950.I1503@niksula.cs.hut.fi>
In-Reply-To: <3B61893D.A532BD6F@namesys.com> <Pine.GSO.4.10.10107270919430.8579-100000@orbit-fe.eng.netapp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.4.10.10107270919430.8579-100000@orbit-fe.eng.netapp.com>; from kmacy@netapp.com on Fri, Jul 27, 2001 at 09:25:23AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Fri, Jul 27, 2001 at 09:25:23AM -0700, you [Kip Macy] claimed:
>  
> sys_write was failing with ENOMEM (on a machine with 1GB of RAM that was 
> not doing anything else).

I second that.

256M memory, no swap at the time.

After fresh boot to the default RH71 kernel (2.4.2-2 or whatever it is) on
console (no X running):

> diff -Naur /usr/src/linux.rh-default /usr/src/linux-2.4.4 > diff
zsh: killed diff

> dmesg | tail
kernel: out of memory, killed process n (xfs)
kernel: out of memory, killed process n (diff)

Phew.


-- v --

v@iki.fi
