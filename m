Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261208AbVFAW6N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261208AbVFAW6N (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 18:58:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261276AbVFAW6N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 18:58:13 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:44428 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S261208AbVFAW6K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 18:58:10 -0400
Date: Wed, 1 Jun 2005 15:58:09 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: linux-kernel@vger.kernel.org, linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH][1/3] RapidIO support: core
Message-ID: <20050601155809.A19099@cox.net>
References: <20050601110836.A16559@cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20050601110836.A16559@cox.net>; from mporter@kernel.crashing.org on Wed, Jun 01, 2005 at 11:08:36AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 01, 2005 at 11:08:36AM -0700, Matt Porter wrote:
> Adds a RapidIO subsystem to the kernel. RIO is a switched
> fabric interconnect used in higher-end embedded applications.
> The curious can look at the specs over at http://www.rapidio.org
> 
> The core code implements enumeration/discovery, management of
> devices/resources, and interfaces for RIO drivers.

I'm also hacking on a rioutils package (derived from pciutils)
that has a lsrio that works pretty much like the familiar
lspci tool.  The initial release can be grabbed from:
ftp://source.mvista.com/pub/rio/rioutils-0.10.tar.bz2

-Matt
