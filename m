Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261325AbVFCPYt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261325AbVFCPYt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 11:24:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261326AbVFCPYt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 11:24:49 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:62391 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP id S261325AbVFCPYp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 11:24:45 -0400
Date: Fri, 3 Jun 2005 11:24:43 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Vivek Goyal <vgoyal@in.ibm.com>
cc: linux kernel mailing list <linux-kernel@vger.kernel.org>, <greg@kroah.com>,
       Fastboot mailing list <fastboot@lists.osdl.org>,
       Morton Andrew Morton <akpm@osdl.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [RFC/PATCH] Kdump: Disabling PCI interrupts in capture kernel
In-Reply-To: <20050603112524.GB7022@in.ibm.com>
Message-ID: <Pine.LNX.4.44L0.0506031111080.6451-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Jun 2005, Vivek Goyal wrote:

> In previous conversations, Alan Stern had raised the issue of console also
> not working if interrupts are disabled on all the devices. I am not sure
> but this should be working at least for serial consoles and vga text consoles.
> May be sufficient to capture the dump.

This isn't an issue for x86.  It affects other architectures, in which the 
system console is managed during the early stages of booting by the 
platform firmware.  I suppose serial consoles would always work.

Alan Stern

