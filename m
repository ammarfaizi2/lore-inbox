Return-Path: <linux-kernel-owner+w=401wt.eu-S965079AbWL2SOP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965079AbWL2SOP (ORCPT <rfc822;w@1wt.eu>);
	Fri, 29 Dec 2006 13:14:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965086AbWL2SOP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Dec 2006 13:14:15 -0500
Received: from iabervon.org ([66.92.72.58]:4994 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965079AbWL2SOO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Dec 2006 13:14:14 -0500
Date: Fri, 29 Dec 2006 13:14:13 -0500 (EST)
From: Daniel Barkalow <barkalow@iabervon.org>
To: Adrian Bunk <bunk@stusta.de>
cc: linux-kernel@vger.kernel.org, Greg KH <gregkh@suse.de>
Subject: Re: 2.6.20-rc2: known unfixed regressions
In-Reply-To: <20061228223909.GK20714@stusta.de>
Message-ID: <Pine.LNX.4.64.0612291234400.20138@iabervon.org>
References: <Pine.LNX.4.64.0612232043030.3671@woody.osdl.org>
 <20061228223909.GK20714@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There's also http://lkml.org/lkml/2006/12/21/47; the included patch break 
my nVidia devices and probably all PCIX devices, so it's not right, but 
something has to be done to fix ATI. My guess is a quirk to say that 
pci_intx doesn't work on certain devices and should just be skipped, but 
I'm not sure if it's just in combination with MSI or not.

	-Daniel
*This .sig left intentionally blank*
