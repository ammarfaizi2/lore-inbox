Return-Path: <linux-kernel-owner+w=401wt.eu-S964881AbXAJOjU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964881AbXAJOjU (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 09:39:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964882AbXAJOjU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 09:39:20 -0500
Received: from caffeine.uwaterloo.ca ([129.97.134.17]:45807 "EHLO
	caffeine.csclub.uwaterloo.ca" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S964881AbXAJOjT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 09:39:19 -0500
Date: Wed, 10 Jan 2007 09:39:19 -0500
To: Jeff Garzik <jeff@garzik.org>
Cc: "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: SATA/IDE Dual Mode w/Intel 945 Chipset or HOW TO LIQUIFY a flash IDE chip under 2.6.18
Message-ID: <20070110143919.GH17269@csclub.uwaterloo.ca>
References: <45A3FF32.1030905@wolfmountaingroup.com> <45A42385.7090904@garzik.org> <45A42670.703@wolfmountaingroup.com> <45A4325C.9060902@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45A4325C.9060902@garzik.org>
User-Agent: Mutt/1.5.9i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 09, 2007 at 07:25:00PM -0500, Jeff Garzik wrote:
> Combined mode is a technical term.  Judging from your answers, you are 
> not using combined mode.

I would have thought 'sata 3.0 + IDE' sounded a lot like combined mode,
unless it means seperate sata and ide.

> Judging from your answers, you are not in AHCI mode.
> 
> Side note:  You should use AHCI if available.  Emulating a PATA 
> interface for SATA devices is error prone [in the silicon].  AHCI is 
> native SATA, "enhanced mode" is not.

I tried setting my sister's new machine to AHCI mode (Asus P5B with 965
chipset), but I eventually gave up since it also needed windows xp on it
and I can't for the life of me find an AHCI driver for windows that
would install.

--
Len Sorensen
