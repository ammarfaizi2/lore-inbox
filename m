Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261840AbVFPVMN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261840AbVFPVMN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Jun 2005 17:12:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261841AbVFPVMN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Jun 2005 17:12:13 -0400
Received: from webmail.topspin.com ([12.162.17.3]:48829 "EHLO
	exch-1.topspincom.com") by vger.kernel.org with ESMTP
	id S261840AbVFPVML (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Jun 2005 17:12:11 -0400
To: Peter Buckingham <peter@pantasys.com>
Cc: Sean Bruno <sean.bruno@dsl-only.net>,
       Andreas Koch <koch@esa.informatik.tu-darmstadt.de>,
       Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
       Linus Torvalds <torvalds@osdl.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       gregkh@suse.de
Subject: Re: PROBLEM: Devices behind PCI Express-to-PCI bridge not mapped
X-Message-Flag: Warning: May contain useful information
References: <20050605204645.A28422@jurassic.park.msu.ru>
	<Pine.LNX.4.58.0506091617130.2286@ppc970.osdl.org>
	<20050610184815.A13999@jurassic.park.msu.ru>
	<200506102247.30842.koch@esa.informatik.tu-darmstadt.de>
	<1118762382.9161.3.camel@home-lap>
	<20050616142039.GF21542@erebor.esa.informatik.tu-darmstadt.de>
	<42B1B4D3.3060600@pantasys.com> <1118955201.10529.10.camel@home-lap>
	<42B1E9B2.30504@pantasys.com>
From: Roland Dreier <roland@topspin.com>
Date: Thu, 16 Jun 2005 14:12:10 -0700
In-Reply-To: <42B1E9B2.30504@pantasys.com> (Peter Buckingham's message of
 "Thu, 16 Jun 2005 14:05:54 -0700")
Message-ID: <52is0e9fbp.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 16 Jun 2005 21:12:10.0490 (UTC) FILETIME=[0F3975A0:01C572B8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Peter> This is a custom motherboard that we've developed in house :-(

Actually this might be good news -- you have a chance at fixing your
BIOS to set up the PCI buses sanely, which will probably help Linux out.

 - R.
