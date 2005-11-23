Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932144AbVKWSSK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932144AbVKWSSK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 13:18:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932137AbVKWSSK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 13:18:10 -0500
Received: from khepri.openbios.org ([80.190.231.112]:22959 "EHLO
	khepri.openbios.org") by vger.kernel.org with ESMTP id S932144AbVKWSSH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 13:18:07 -0500
Date: Wed, 23 Nov 2005 19:18:04 +0100
From: Stefan Reinauer <stepan@openbios.org>
To: yhlu <yinghailu@gmail.com>
Cc: Andi Kleen <ak@suse.de>, discuss@x86-64.org, linuxbios@openbios.org,
       yhlu <yhlu.kernel@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [LinuxBIOS] x86_64: apic id lift patch
Message-ID: <20051123181804.GC27398@openbios.org>
References: <86802c440511211349t6a0a9d30i60e15fa23b86c49d@mail.gmail.com> <20051121220605.GD20775@brahms.suse.de> <43849FA5.4020201@lanl.gov> <2ea3fae10511230919l4d9829d8j3ce5d820b74074d1@mail.gmail.com> <20051123173636.GL20775@brahms.suse.de> <2ea3fae10511230940t1f6a1757lf885a2559be6f0dc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ea3fae10511230940t1f6a1757lf885a2559be6f0dc@mail.gmail.com>
X-Operating-System: Linux 2.6.14-20051104171614-smp on an x86_64
User-Agent: Mutt/1.5.9i
X-Duff: Orig. Duff, Duff Lite, Duff Dry, Duff Dark,
	Raspberry Duff, Lady Duff, Red Duff, Tartar Control Duff
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* yhlu <yinghailu@gmail.com> [051123 18:40]:
> is there any way to make the kernel use apci but still use pci irq
> routing from mptable?

Yes, don't provide any of MADT, DSDT, FADT.

   Stefan

