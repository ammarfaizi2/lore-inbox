Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132701AbRC2N1O>; Thu, 29 Mar 2001 08:27:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132729AbRC2N1E>; Thu, 29 Mar 2001 08:27:04 -0500
Received: from [63.95.87.168] ([63.95.87.168]:36873 "HELO xi.linuxpower.cx")
	by vger.kernel.org with SMTP id <S132701AbRC2N1B>;
	Thu, 29 Mar 2001 08:27:01 -0500
Date: Thu, 29 Mar 2001 08:25:50 -0500
From: Gregory Maxwell <greg@linuxpower.cx>
To: Erik van Asselt <e.van.asselt@planet.nl>
Cc: Andre Hedrick <andre@linux-ide.org>,
   "Henning P. Schmiedehausen" <hps@tanstaafl.de>,
   linux-kernel@vger.kernel.org
Subject: Re: Promise RAID controller howto?
Message-ID: <20010329082550.B4681@xi.linuxpower.cx>
In-Reply-To: <Pine.LNX.4.10.10103270806300.16125-100000@master.linux-ide.org> <3AC31147.6035E09C@planet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.8i
In-Reply-To: <3AC31147.6035E09C@planet.nl>; from e.van.asselt@planet.nl on Thu, Mar 29, 2001 at 12:41:11PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 29, 2001 at 12:41:11PM +0200, Erik van Asselt wrote:
> Hmmmmm i have the Promise raid source for 2.2 kernel modules so what do you mean
> by opensource signatures
> 
> i have it working for 2.2 kernels but i can't get it to work properly in 2.4
> So if someone want to look at the source !!!
> it can be found on www.promise.com

The promise controller is not a hardware raid board, it is a regular IDE
controller with a bios overlay. Their marketing is deceiving and fraudulent.

Their software raid is less flexible then Linuxes, and it's performance is
inferior. The only advantages of a promise 'raid' controller is cross-OS
compatibility and a simplified booting process.

Promises Linux 'drivers' are proprietary and a violation of the GPL. Because
their drivers are closed source, you can not debug any kernel with it loaded
and you will not be compatible with future upgrades to your kernel without
promises good will.

Because of these reasons, it would be advantageous for Linux to understand
promises boot signature and allow Linuxes built in raid driver to be used on
promises 'raid' disk. Allowing for the cross-os compatibility and easy
booting but retaining the flexible, high performance and open source of the
Linux code.

Unfortunately, promise is more concerned with living their lie then providing
a high quality product to their customers and refuses to provide the tiny
bit of needed information.
