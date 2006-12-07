Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1163711AbWLGXEI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1163711AbWLGXEI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 18:04:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1163742AbWLGXEI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 18:04:08 -0500
Received: from iabervon.org ([66.92.72.58]:1332 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1163711AbWLGXEF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 18:04:05 -0500
Date: Thu, 7 Dec 2006 18:04:04 -0500 (EST)
From: Daniel Barkalow <barkalow@iabervon.org>
To: Greg KH <gregkh@suse.de>
cc: Jeff Garzik <jeff@garzik.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Disable INTx when enabling MSI
In-Reply-To: <20061207223949.GA18477@suse.de>
Message-ID: <Pine.LNX.4.64.0612071745270.20138@iabervon.org>
References: <Pine.LNX.4.64.0612071659010.20138@iabervon.org>
 <20061207223949.GA18477@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Dec 2006, Greg KH wrote:

> Care to take Jeff's proposed patch, verify that it works and forward it
> on to me?

I'll test it tomorrow. Testing disables my network, and making sure the 
problem exists without the patch kills my disk controller, so I need to 
sit at the computer for a while. I assume that I've got the only known 
device that demonstrates the need for this?

Off topic: would it be wise as a general rule to somehow shut down devices 
whose interrupts get disabled by the "nobody cared!" code? Or maybe call 
their interrupt handlers periodically to keep them alive?

	-Daniel
*This .sig left intentionally blank*
