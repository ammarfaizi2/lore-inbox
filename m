Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262112AbVC1XFM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262112AbVC1XFM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 18:05:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262109AbVC1XDX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 18:03:23 -0500
Received: from mail.kroah.org ([69.55.234.183]:14014 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262106AbVC1XBh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 18:01:37 -0500
Date: Mon, 28 Mar 2005 15:00:57 -0800
From: Greg KH <greg@kroah.com>
To: Rolf Eike Beer <eike-kernel@sf-tec.de>
Cc: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [PATCH] shrink drivers/pci/proc.c::pci_seq_start()
Message-ID: <20050328230057.GA4941@kroah.com>
References: <200503271605.43967.eike-kernel@sf-tec.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200503271605.43967.eike-kernel@sf-tec.de>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 27, 2005 at 03:05:43PM +0100, Rolf Eike Beer wrote:
> Hi,
> 
> this patch shrinks pci_seq_start by using for_each_pci_dev() macro instead
> of explicitely using a loop and avoiding a goto.
> 
> Eike
> 
> Signed-off-by: Rolf Eike Beer <eike-kernel@sf-tec.de>

Applied, thanks.

greg k-h
