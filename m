Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261977AbVASX1B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261977AbVASX1B (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 18:27:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261980AbVASX0Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 18:26:16 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:62146 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261977AbVASXZP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 18:25:15 -0500
Date: Wed, 19 Jan 2005 15:22:53 -0800
From: Greg KH <greg@kroah.com>
To: Aur?lien Jarno <aurelien@aurel32.net>, sensors@Stimpy.netroedge.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6] I2C: Fix DS1621 detection
Message-ID: <20050119232253.GA5909@kroah.com>
References: <20050119202749.GA19261@bode.aurel32.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050119202749.GA19261@bode.aurel32.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 19, 2005 at 09:27:49PM +0100, Aur?lien Jarno wrote:
> Hi Greg,
> 
> Dallas Semiconductors as recently changed the design of their DS1621
> chips, including the bits that were checked in the kernel driver to 
> detect it.
> 
> The patch below fixes the detection by checking an other bit of the
> configuration register instead.
> 
> Please apply.

Applied, thanks.

greg k-h
