Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267278AbTBISBo>; Sun, 9 Feb 2003 13:01:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267333AbTBISBo>; Sun, 9 Feb 2003 13:01:44 -0500
Received: from ip68-101-124-193.oc.oc.cox.net ([68.101.124.193]:16003 "EHLO
	ip68-4-86-174.oc.oc.cox.net") by vger.kernel.org with ESMTP
	id <S267278AbTBISBn>; Sun, 9 Feb 2003 13:01:43 -0500
Date: Sun, 9 Feb 2003 10:11:26 -0800
From: "Barry K. Nathan" <barryn@pobox.com>
To: MaxF <maxer1@xmission.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Firewire Buslink dirve incorrectly detected as a LiteOn in 2.4.20
Message-ID: <20030209181126.GA2732@ip68-4-86-174.oc.oc.cox.net>
References: <3E466E84.3060907@xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E466E84.3060907@xmission.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 09, 2003 at 08:06:44AM -0700, MaxF wrote:
> All kernels post 2.4.20-xx are detecting my firewire Buslink CD-RW
> as:
> 
> Feb  9 07:54:19 maxer kernel:   Vendor: LITE-ON   Model: 
> LTR-48125W        Rev: VS06
> 
> Buslink model #RW4848FE
> 
> I do have however a second drive that is a Lite-On, but is not firewire.
> 
> Any ideas?

Many of the Buslink FireWire drives have Lite-On drives inside. The
output you pasted is exactly what I'd expect from a BusLink FireWire
CD-RW.

Is this a change in behavior from previous kernels (i.e., did it show
something different in the past?) If so, what did an older kernel show?
If there's a difference, that could indeed be a bug.

Conversely, if you're merely surprised that one company manufactured the
drive and a different company put the drive into a FireWire enclosure, I
wouldn't consider that to be a bug in Linux.

-Barry K. Nathan <barryn@pobox.com>
