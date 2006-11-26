Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967245AbWKZCsN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967245AbWKZCsN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Nov 2006 21:48:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967246AbWKZCsN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Nov 2006 21:48:13 -0500
Received: from cavan.codon.org.uk ([217.147.92.49]:45524 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S967245AbWKZCsM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Nov 2006 21:48:12 -0500
Date: Sun, 26 Nov 2006 02:48:04 +0000
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: Arjan van de Ven <arjan@infradead.org>, Casey Dahlin <cjdahlin@ncsu.edu>,
       linux-kernel@vger.kernel.org
Subject: Re: Overriding X on panic
Message-ID: <20061126024804.GA31281@srcf.ucam.org>
References: <1164434093.10503.2.camel@localhost.localdomain> <1164443561.3147.54.camel@laptopd505.fenrus.org> <20061125161043.18f1b68d@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061125161043.18f1b68d@localhost.localdomain>
User-Agent: Mutt/1.5.9i
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@codon.org.uk
X-SA-Exim-Scanned: No (on vavatch.codon.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 25, 2006 at 04:10:43PM +0000, Alan wrote:
> > modesettings to use can still be in userspace, the execution of the
> > series of IO's would be in the kernel, and the kernel would store
> > bundles of settings, including a "rescue" one, but also for
> > suspend/resume...
> 
> The mode switch sequences for modern cards are a bit more hairy than
> lists of I/O poking unfortunately. 

The int 10 call to get back to text mode generally seems to work, but, 
uh. Yeah. Maybe not.

(I'm sure nobody would /really/ object to linking x86emu into the 
kernel...)
-- 
Matthew Garrett | mjg59@srcf.ucam.org
