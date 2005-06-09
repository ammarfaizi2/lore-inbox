Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262222AbVFINzE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262222AbVFINzE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 09:55:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262349AbVFINzE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 09:55:04 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:57999 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S262222AbVFINzB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 09:55:01 -0400
Date: Thu, 9 Jun 2005 17:54:41 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Andreas Koch <koch@esa.informatik.tu-darmstadt.de>,
       Linus Torvalds <torvalds@osdl.org>, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org, gregkh@suse.de
Subject: Re: PROBLEM: Devices behind PCI Express-to-PCI bridge not mapped
Message-ID: <20050609175441.C9187@jurassic.park.msu.ru>
References: <Pine.LNX.4.58.0506031851220.1876@ppc970.osdl.org> <20050604022600.GA8221@erebor.esa.informatik.tu-darmstadt.de> <Pine.LNX.4.58.0506032149130.1876@ppc970.osdl.org> <20050604155742.GA14384@erebor.esa.informatik.tu-darmstadt.de> <20050605204645.A28422@jurassic.park.msu.ru> <20050606002739.GA943@erebor.esa.informatik.tu-darmstadt.de> <20050606184335.A30338@jurassic.park.msu.ru> <20050608173409.GA32004@erebor.esa.informatik.tu-darmstadt.de> <20050609023639.A7067@jurassic.park.msu.ru> <1118289850.6850.164.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1118289850.6850.164.camel@gaston>; from benh@kernel.crashing.org on Thu, Jun 09, 2005 at 02:04:10PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 09, 2005 at 02:04:10PM +1000, Benjamin Herrenschmidt wrote:
> Hrm... IO at 0 for a P2P bridge is perfectly valid, at least on a number
> of architectures...

Sure, but on x86 it blocks access to VGA registers and other legacy
stuff. That's why Andreas' machine hangs, I suppose.

Ivan.
