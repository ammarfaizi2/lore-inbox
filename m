Return-Path: <linux-kernel-owner+w=401wt.eu-S965001AbXAJR6w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965001AbXAJR6w (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 12:58:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965004AbXAJR6w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 12:58:52 -0500
Received: from caffeine.uwaterloo.ca ([129.97.134.17]:54466 "EHLO
	caffeine.csclub.uwaterloo.ca" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S965001AbXAJR6v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 12:58:51 -0500
Date: Wed, 10 Jan 2007 12:58:50 -0500
To: "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>
Cc: Prakash Punnoor <prakash@punnoor.de>, Jeff Garzik <jeff@garzik.org>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: SATA/IDE Dual Mode w/Intel 945 Chipset or HOW TO LIQUIFY a flash IDE chip under 2.6.18
Message-ID: <20070110175850.GM17267@csclub.uwaterloo.ca>
References: <45A3FF32.1030905@wolfmountaingroup.com> <45A4325C.9060902@garzik.org> <20070110143919.GH17269@csclub.uwaterloo.ca> <200701101829.32369.prakash@punnoor.de> <20070110174710.GL17267@csclub.uwaterloo.ca> <45A521A0.9050205@wolfmountaingroup.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45A521A0.9050205@wolfmountaingroup.com>
User-Agent: Mutt/1.5.9i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 10, 2007 at 10:25:52AM -0700, Jeff V. Merkey wrote:
> No doubt part of the Wintel (intel + Microsoft) strategy to perpetually 
> break non-windows platforms with new incompatible
> hardware like the switch over from the e1000 MT adapters to e1000 GT 
> which are not backward compatible with the older chipsets.
> 
> I still have not seen the GT adapter work correctly off windows.

But isn't AHCI a new standard intel helped develop?  Why would they want
to make it hard to use intel hardware using a standard interface intel
helped create?  It makes no sense.  Linux doesn't care if the sata is
set to the old PATA compatible interface, or the new AHCI mode.  Windows
simply can't boot in AHCI mode and refuses to install a driver for
AHCI mode when it is not already in AHCI mode.

--
Len Sorensen
