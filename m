Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261625AbVFPVV6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261625AbVFPVV6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Jun 2005 17:21:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261837AbVFPVV6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Jun 2005 17:21:58 -0400
Received: from 64-60-250-34.cust.telepacific.net ([64.60.250.34]:27835 "EHLO
	panta-1.pantasys.com") by vger.kernel.org with ESMTP
	id S261625AbVFPVV4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Jun 2005 17:21:56 -0400
Message-ID: <42B1ED72.3010000@pantasys.com>
Date: Thu, 16 Jun 2005 14:21:54 -0700
From: Peter Buckingham <peter@pantasys.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Roland Dreier <roland@topspin.com>
CC: Sean Bruno <sean.bruno@dsl-only.net>,
       Andreas Koch <koch@esa.informatik.tu-darmstadt.de>,
       Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
       Linus Torvalds <torvalds@osdl.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       gregkh@suse.de
Subject: Re: PROBLEM: Devices behind PCI Express-to-PCI bridge not mapped
References: <20050605204645.A28422@jurassic.park.msu.ru>	<Pine.LNX.4.58.0506091617130.2286@ppc970.osdl.org>	<20050610184815.A13999@jurassic.park.msu.ru>	<200506102247.30842.koch@esa.informatik.tu-darmstadt.de>	<1118762382.9161.3.camel@home-lap>	<20050616142039.GF21542@erebor.esa.informatik.tu-darmstadt.de>	<42B1B4D3.3060600@pantasys.com> <1118955201.10529.10.camel@home-lap>	<42B1E9B2.30504@pantasys.com> <52is0e9fbp.fsf@topspin.com>
In-Reply-To: <52is0e9fbp.fsf@topspin.com>
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 16 Jun 2005 21:19:24.0750 (UTC) FILETIME=[121046E0:01C572B9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland Dreier wrote:
>     Peter> This is a custom motherboard that we've developed in house :-(
> 
> Actually this might be good news -- you have a chance at fixing your
> BIOS to set up the PCI buses sanely, which will probably help Linux out.

basically this works under windows (not a good answer i know...)

my impression from talking to the bios guys it is okay for them not to 
configure the non-primary video adapter (read they won't do it).

we do something similar for IB. the IB attached to the master nforce4 is 
configured by the bios and the other 3 are not. Each of these IB devices 
are configured by Linux correctly.

Similarly when the ATI is the primary graphics adapter it is sanely 
configured and the other GPUs are not.

peter
