Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318974AbSICXWa>; Tue, 3 Sep 2002 19:22:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318980AbSICXW3>; Tue, 3 Sep 2002 19:22:29 -0400
Received: from dsl-213-023-043-116.arcor-ip.net ([213.23.43.116]:34456 "EHLO
	starship") by vger.kernel.org with ESMTP id <S318974AbSICXW2>;
	Tue, 3 Sep 2002 19:22:28 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Matt Domsch <Matt_Domsch@Dell.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] x86 BIOS Enhanced Disk Device (EDD) polling
Date: Wed, 4 Sep 2002 01:29:37 +0200
X-Mailer: KMail [version 1.3.2]
References: <Pine.LNX.4.44.0209031616580.30474-100000@humbolt.us.dell.com>
In-Reply-To: <Pine.LNX.4.44.0209031616580.30474-100000@humbolt.us.dell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17mN73-0005mq-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 04 September 2002 00:05, Matt Domsch wrote:
>
> [...]
>
> EDD works by providing the bus (PCI, PCI-X, ISA, InfiniBand, PCI
> Express, or HyperTransport) location (e.g. PCI 02:01.0) and interface
> (ATAPI, ATA, SCSI, USB, 1394, FibreChannel, I2O, RAID, SATA) location
> (e.g. SCSI ID 5 LUN 0) information for each BIOS int13 device.  The
> patch below creates CONFIG_EDD, that when defined, makes the calls to
> retrieve and store this information.  It then exports it (yes, another
> /proc, glad to change it to driverfs or whatever else when that makes
> sense) in /proc/edd/{bios-device-number}, as such:
>
> [...]
>
>
> Feedback appreciated.

How about providing an example of how you'd export the root via driverfs,
with a view to educating those of us who are still don't have much of a
clue how driverfs fits in with big picture?

-- 
Daniel
