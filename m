Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1163628AbWLGXJx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1163628AbWLGXJx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 18:09:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1163838AbWLGXJx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 18:09:53 -0500
Received: from smtp.osdl.org ([65.172.181.25]:52996 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1163628AbWLGXJv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 18:09:51 -0500
Date: Thu, 7 Dec 2006 15:09:35 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Jeff Garzik <jeff@garzik.org>, Takashi Iwai <tiwai@suse.de>
cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       gregkh@suse.de, barkalow@iabervon.org
Subject: Re: [git patch] improve INTx toggle for PCI MSI
In-Reply-To: <20061207225812.GA13917@havoc.gtf.org>
Message-ID: <Pine.LNX.4.64.0612071504570.3615@woody.osdl.org>
References: <20061207225812.GA13917@havoc.gtf.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 7 Dec 2006, Jeff Garzik wrote:
> 
> "it boots" on ICH7 at least.

Ok. Pulled, pushed out.

There was some noise saying that this may actually fix the problems with 
the NVidia "Intel HDA" sound situation? Can people who saw that issue try 
it out whether this just makes MSI works for them?

Takashi added to the To: field, because he hopefully remembers and has a 
clue about the proper identities in question.. Iirc, you needed to have 
not only a NVidia chipset, but also have the legacy interrupt shared with 
some other device to see the problem.

		Linus
