Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129825AbRBZUHF>; Mon, 26 Feb 2001 15:07:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129835AbRBZUG4>; Mon, 26 Feb 2001 15:06:56 -0500
Received: from assembly.state.ny.us ([204.97.104.2]:52634 "EHLO
	assembly.state.ny.us") by vger.kernel.org with ESMTP
	id <S129825AbRBZUGl>; Mon, 26 Feb 2001 15:06:41 -0500
Date: Mon, 26 Feb 2001 15:06:13 -0500
From: jerry <jdinardo@ix.netcom.com>
To: David Balazic <david.balazic@uni-mb.si>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ide / usb problem
Message-ID: <20010226150613.A772@ix.netcom.com>
In-Reply-To: <3A9AABE8.3549CF95@uni-mb.si>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A9AABE8.3549CF95@uni-mb.si>; from david.balazic@uni-mb.si on Mon, Feb 26, 2001 at 08:18:00PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I did use that option. The system works but it generates a large number of
the BadCRC messages when I do heavy io. Using then generic dma bus master
support gives me fast io without the messages.

jpd

> If you use the VIA IDE driver, then you _must_ turn on
> the "Automatically enable DMA for PCI-IDE" kernel configuration
> option. It is said in the help text for the VIA-IDE option.
> 
