Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262414AbVAZKDr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262414AbVAZKDr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 05:03:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262415AbVAZKDr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 05:03:47 -0500
Received: from aun.it.uu.se ([130.238.12.36]:32209 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S262414AbVAZKDR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 05:03:17 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16887.27336.161685.55774@alkaid.it.uu.se>
Date: Wed, 26 Jan 2005 11:02:48 +0100
From: Mikael Pettersson <mikpe@csd.uu.se>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Mikael Pettersson <mikpe@csd.uu.se>,
       linuxppc-dev list <linuxppc-dev@ozlabs.org>,
       Paul Mackerras <paulus@samba.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: BUG: 2.6.11-rc2 and -rc1 hang during boot on PowerMacs
In-Reply-To: <1106696846.6250.20.camel@gaston>
References: <200501221723.j0MHN6eD000684@harpo.it.uu.se>
	<1106441036.5387.41.camel@gaston>
	<1106529935.5587.9.camel@gaston>
	<16885.13185.849070.479328@alkaid.it.uu.se>
	<1106623515.6244.11.camel@gaston>
	<16886.2489.823835.17801@alkaid.it.uu.se>
	<1106696846.6250.20.camel@gaston>
X-Mailer: VM 7.17 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt writes:
 > On Tue, 2005-01-25 at 09:56 +0100, Mikael Pettersson wrote:
 > 
 > > On the eMac:
 > > /proc/sys/kernel/powersave-nap exists and contains "0".
 > > /proc/device-tree/cpus/PowerPC,G4/flush-on-lock exists as an empty file.
 > 
 > Ok, that is weird... so for some reason, Apple decided not to allow the
 > eMac to do NAP mode, and thus to power manage the CPU when idle...

I assumed it was due to the UniNorth issue that pmac_feature.c mentions.

/Mikael
