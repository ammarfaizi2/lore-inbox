Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261272AbVCGXxY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261272AbVCGXxY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 18:53:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261311AbVCGXsP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 18:48:15 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:10625 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261916AbVCGXpU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 18:45:20 -0500
From: Jesse Barnes <jbarnes@sgi.com>
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [RFC][PATCH] PCI bridge driver rewrite (rev 02)
Date: Mon, 7 Mar 2005 15:43:30 -0800
User-Agent: KMail/1.7.2
Cc: Adam Belay <abelay@novell.com>, greg@kroah.com,
       linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
References: <1110234742.2456.37.camel@localhost.localdomain> <9e47339105030715395b7bc61e@mail.gmail.com>
In-Reply-To: <9e47339105030715395b7bc61e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503071543.31089.jbarnes@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, March 7, 2005 3:39 pm, Jon Smirl wrote:
> How is sys/bus/platform/* going to work for IA64 machine line SGI SVN?
> SVN supports multiple simultaneously active legacy spaces, that means
> that there can be multiple floppy, serial, ps/2, etc controllers.
> Should these devices be hung off from the bridge they are on?

Probably, though no one in their right mind is going to put anything like that 
on these machines (sn2 btw) :).  VGA cards will hopefully be the only devices 
of this type that we'll have installed.

Jesse
