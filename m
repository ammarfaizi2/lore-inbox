Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751666AbWAJAAn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751666AbWAJAAn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 19:00:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751667AbWAJAAn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 19:00:43 -0500
Received: from smtp.osdl.org ([65.172.181.4]:57020 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751665AbWAJAAm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 19:00:42 -0500
Date: Mon, 9 Jan 2006 16:00:28 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Greg KH <gregkh@suse.de>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [GIT PATCH] PCI patches for 2.6.15 - retry
In-Reply-To: <20060109203711.GA25023@kroah.com>
Message-ID: <Pine.LNX.4.64.0601091557480.5588@g5.osdl.org>
References: <20060109203711.GA25023@kroah.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 9 Jan 2006, Greg KH wrote:
>
> Here are some PCI patches against your latest git tree.  They have all
> been in the -mm tree for a while with no problems.  I've pulled out all
> of the offending patches that people objected to, or ones that crashed
> older machines from the last series I sent you.

Before I pull this, I'd like to get some confirmation that some of the 
other problems that seem to be PCI-related in the -mm tree are also 
understood, or at least known to be part of the stuff that you're _not_ 
sending me..

[ There's at least a pci_call_probe() NULL ptr dereference report by 
  Martin Bligh, I think Andrew has a few others he's tracked.. ]

		Linus
