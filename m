Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269664AbUJAB4g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269664AbUJAB4g (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 21:56:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269669AbUJAB4f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 21:56:35 -0400
Received: from convulsion.choralone.org ([212.13.208.157]:59144 "EHLO
	convulsion.choralone.org") by vger.kernel.org with ESMTP
	id S269664AbUJAB4d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 21:56:33 -0400
Date: Fri, 1 Oct 2004 02:56:08 +0100
From: Dave Jones <davej@redhat.com>
To: Greg KH <greg@kroah.com>
Cc: ak@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix improper use of pci_module_init() in drivers/char/agp/amd64-agp.c
Message-ID: <20041001015558.GA8657@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, Greg KH <greg@kroah.com>,
	ak@suse.de, linux-kernel@vger.kernel.org
References: <20040930184248.GA17546@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040930184248.GA17546@kroah.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 30, 2004 at 11:42:48AM -0700, Greg KH wrote:
 > Hi,
 
Hi Greg,

 > In going through the tree and auditing the usage of pci_module_init(), I
 > noticed that the amd64-agp driver was assuming that the return value of
 > this function could be greater than 0 (which is what could happen in 2.2
 > and 2.4 kernels.)  As this is no longer true, I think the following
 > patch is correct.
 > 
 > I can add this to my bk-pci tree if you wish, otherwise feel free to
 > send it upwards.

I'm going through all kinds of busyness due to a relocation right now,
so feel free to push this yourself after you and Andi are done beating
out the details.

		Dave

