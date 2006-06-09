Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030180AbWFIOye@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030180AbWFIOye (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 10:54:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030186AbWFIOye
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 10:54:34 -0400
Received: from caffeine.uwaterloo.ca ([129.97.134.17]:47745 "EHLO
	caffeine.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S1030180AbWFIOye (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 10:54:34 -0400
Date: Fri, 9 Jun 2006 10:54:33 -0400
To: Dieter St?ken <stueken@conterra.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: mixing 32 and 64 bit?
Message-ID: <20060609145433.GB560@csclub.uwaterloo.ca>
References: <44893D00.8090807@conterra.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44893D00.8090807@conterra.de>
User-Agent: Mutt/1.5.9i
From: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: lsorense@csclub.uwaterloo.ca
X-SA-Exim-Scanned: No (on caffeine.csclub.uwaterloo.ca); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 09, 2006 at 11:18:56AM +0200, Dieter St?ken wrote:
> I just wonder how some userland applications are able to use 64-bit 
> capabilities although they are started by an  ELF 32-bit binary. I observed
> this when installing vmware: Even if the binary is an ELF32, it is
> able to provide an 64Bit ABI to its guest OS. Until now I thought a
> process is either 32bit or 64bit. Seems this is not true. 
> 
> Has some one a good link or entry point about this topic?
> I could not find a matching keyword to search for. 

VMware also has some kernel modules, which are compiled in whatever
format the kernel is.  I suspect some of this ability comes from those
kernel modules, rather than the user interface you use to control the
vm.

Len Sorensen
