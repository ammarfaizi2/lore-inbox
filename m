Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751305AbWHaIad@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751305AbWHaIad (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 04:30:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751346AbWHaIad
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 04:30:33 -0400
Received: from smtp19.orange.fr ([80.12.242.17]:17914 "EHLO
	smtp-msa-out19.orange.fr") by vger.kernel.org with ESMTP
	id S1751305AbWHaIad (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 04:30:33 -0400
X-ME-UUID: 20060831083031917.E01261C000ED@mwinf1909.orange.fr
Subject: Re: [RFC] Simple userspace interface for PCI drivers
From: Xavier Bestel <xavier.bestel@free.fr>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
In-Reply-To: <20060830062338.GA10285@kroah.com>
References: <20060830062338.GA10285@kroah.com>
Content-Type: text/plain
Message-Id: <1157013027.7566.515.camel@capoeira>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-1) 
Date: Thu, 31 Aug 2006 10:30:27 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Wed, 2006-08-30 at 08:23, Greg KH wrote:
[...]
> Thomas and I lamented that we were getting tired of seeing stuff like
> this, and it was about time that we added the proper code to the kernel
> to provide everything that would be needed in order to write PCI drivers
> in userspace in a sane manner.  Really all that is needed is a way to
> handle the interrupt, everything else can already be done in userspace
> (look at X for an example of this...)
[...]
> So, here's the code. 

I know I look like I'm trolling here, but as this is the perfect
stable-binary-driver-ABI some people have been looking for, it would be
wise to make it taint the kernel with its own flag.

	Xav

