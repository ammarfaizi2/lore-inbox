Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317480AbSFRQZr>; Tue, 18 Jun 2002 12:25:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317481AbSFRQZr>; Tue, 18 Jun 2002 12:25:47 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:778 "EHLO
	master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S317480AbSFRQZp>; Tue, 18 Jun 2002 12:25:45 -0400
Date: Tue, 18 Jun 2002 09:22:02 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Garet Cammer <arcolin@arcoide.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Need IDE Taskfile Access
In-Reply-To: <004701c216cf$efd1ca60$8201a8c0@arcoi0s17j2t0x>
Message-ID: <Pine.LNX.4.10.10206180917550.3804-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Garet,

You are wasting electons, the interface is gone and the API to the
transport is wrecked.  I will need to compose a loadable module to renable
the support.  Clearly 2.5/2.6 is not friendly with the needs of the
industry and it will never be at this rate.

In the end, I will end up writing a closed ATA binary driver for sale as a
replacement.  I have had several requests to consider the option.  As much
as I do not like the idea, it is less offensive than the current
direction.

Andre Hedrick
LAD Storage Consulting Group


On Tue, 18 Jun 2002, Garet Cammer wrote:

> For some time now we have been writing user applications that send ATAPI commands to the IDE bus to initialize and configure our hardware RAID 1 controllers. This has been working well, thanks to Andre's patch that gave us taskfile access through the ioctl API. We were counting on it to be a permanent part of the 2.5/2.6 kernel, since there is a lot of hardware in the field using these apps.
> Imagine our surprise when we discovered that taskfile access was being abandoned completely!
> Although we understand that the kernel may need to filter some commands, why can't applications access at least the Smart commands? Help!
> Regards,
> Garet Cammer
> Software Development
> Arco Computer Products
> (954) 925-2688
> 

