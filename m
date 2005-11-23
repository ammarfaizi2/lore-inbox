Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030273AbVKWAZg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030273AbVKWAZg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 19:25:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030274AbVKWAZg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 19:25:36 -0500
Received: from smtp.osdl.org ([65.172.181.4]:15311 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030273AbVKWAZf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 19:25:35 -0500
Date: Tue, 22 Nov 2005 16:25:58 -0800
From: Andrew Morton <akpm@osdl.org>
To: Greg KH <greg@kroah.com>
Cc: david.fox@linspire.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6.15-rc2 pci_ids.h cleanup is a pain
Message-Id: <20051122162558.702fae4a.akpm@osdl.org>
In-Reply-To: <20051121224438.GA18966@kroah.com>
References: <438249CB.8050200@linspire.com>
	<20051121224438.GA18966@kroah.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <greg@kroah.com> wrote:
>
> On Mon, Nov 21, 2005 at 02:27:23PM -0800, David Fox wrote:
> > I'm sure I'm not the only person that applies patches to the kernel that 
> > use some of the 500 plus PCI IDS eliminated from pci_ids.h by rc2.  I 
> > would like to see the PCI ids that were removed simply because the don't 
> > occur in the main kernel source restored.  Is there a rationale for 
> > removing them that I'm not aware of?
> 
> They were not being used.  Why would you want them in there?

Because they contained useful information which had been accumulated by
many people over a long period of time.

Throwing that information away seemed rather pointless, especially as the
cost of retaining it was so low.
