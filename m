Return-Path: <linux-kernel-owner+w=401wt.eu-S965000AbXAJSAb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965000AbXAJSAb (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 13:00:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965003AbXAJSAb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 13:00:31 -0500
Received: from caffeine.uwaterloo.ca ([129.97.134.17]:54536 "EHLO
	caffeine.csclub.uwaterloo.ca" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S965000AbXAJSAb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 13:00:31 -0500
Date: Wed, 10 Jan 2007 13:00:30 -0500
To: Prakash Punnoor <prakash@punnoor.de>
Cc: Jeff Garzik <jeff@garzik.org>,
       "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: SATA/IDE Dual Mode w/Intel 945 Chipset or HOW TO LIQUIFY a flash IDE chip under 2.6.18
Message-ID: <20070110180030.GN17267@csclub.uwaterloo.ca>
References: <45A3FF32.1030905@wolfmountaingroup.com> <200701101829.32369.prakash@punnoor.de> <20070110174710.GL17267@csclub.uwaterloo.ca> <200701101856.07137.prakash@punnoor.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200701101856.07137.prakash@punnoor.de>
User-Agent: Mutt/1.5.9i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 10, 2007 at 06:56:05PM +0100, Prakash Punnoor wrote:
> Intel wants you to buy hw with ICH8R. ICH8 isn't get the advanced features for 
> free....

But the BIOS has AHCI mode as an option.  I don't want their fake raid,
just ahci.  That isn't an advanced feature, it is native mode. :)

> To get the driver going: Put your hd to the jmicron, install driver, put hd 
> back to ich8...

Hmm, could try that, assuming the jmicron controller doesn't mind.  Of
course the jmicron can also be set to ahci mode (not that I have an ahci
driver for it either under windows).

--
Len Sorensen
