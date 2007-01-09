Return-Path: <linux-kernel-owner+w=401wt.eu-S932495AbXAIW7m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932495AbXAIW7m (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 17:59:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932497AbXAIW7l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 17:59:41 -0500
Received: from caffeine.uwaterloo.ca ([129.97.134.17]:36575 "EHLO
	caffeine.csclub.uwaterloo.ca" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932496AbXAIW7l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 17:59:41 -0500
Date: Tue, 9 Jan 2007 17:59:40 -0500
To: "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: SATA/IDE Dual Mode w/Intel 945 Chipset or HOW TO LIQUIFY a flash IDE chip under 2.6.18
Message-ID: <20070109225940.GG17269@csclub.uwaterloo.ca>
References: <45A3FF32.1030905@wolfmountaingroup.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45A3FF32.1030905@wolfmountaingroup.com>
User-Agent: Mutt/1.5.9i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 09, 2007 at 01:46:42PM -0700, Jeff V. Merkey wrote:
> I just finished pulling out a melted IDE flash drive out of a Shuttle 
> motherboard with the intel 945 chipset which claims to support
> SATA and IDE drives concurrently under Linux 2.6.18.
> 
> The chip worked for about 30 seconds before liquifying in the chassis.  
> I note that the 945 chipset in the shuttle PC had some serious
> issues recognizing 2 x SATA devices and a IDE device concurrently.   Are 
> there known problems with the Linux drivers
> with these newer chipsets.

Had the drive ever been used in any other machine?  Had any ide device
ever been used in this machine before?  It really sounds like a hardware
problem, since I can't think of anything software could do to make that
kind of current go through the flash drive.

I remember seeing the controller chip on a 730MB quantum scsi drive
start to glow red many years ago, just before the drive stopped
responding to the system (and I turned off the power).  Hardware does
fail.  It almost never has anything to do with software.

--
Len Sorensen
