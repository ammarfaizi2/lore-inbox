Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268896AbRHBLpN>; Thu, 2 Aug 2001 07:45:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268899AbRHBLpE>; Thu, 2 Aug 2001 07:45:04 -0400
Received: from ma-northadams1a-359.bur.adelphia.net ([24.52.175.103]:516 "EHLO
	ma-northadams1a-359.bur.adelphia.net") by vger.kernel.org with ESMTP
	id <S268896AbRHBLox>; Thu, 2 Aug 2001 07:44:53 -0400
Date: Thu, 2 Aug 2001 07:45:37 -0400
From: Eric Buddington <eric@ma-northadams1a-359.bur.adelphia.net>
To: "Grover, Andrew" <andrew.grover@intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.7-ac3 panic on boot (acpi?)
Message-ID: <20010802074536.A61@ma-northadams1a-359.bur.adelphia.net>
Reply-To: ebuddington@wesleyan.edu
In-Reply-To: <4148FEAAD879D311AC5700A0C969E89006CDE005@orsmsx35.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <4148FEAAD879D311AC5700A0C969E89006CDE005@orsmsx35.jf.intel.com>; from andrew.grover@intel.com on Wed, Aug 01, 2001 at 03:33:50PM -0700
Organization: ECS Labs
X-Eric-Conspiracy: there is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andy,

I untarred that into my existing 2.4.7-ac3 tree, ran make dep; make
clean; make bzImage, and rebooted. I got "Ran out of input data" right
after the "uncompressing..." message.

Does this patch need to go against vanilla 2.4.7?

-Eric

On Wed, Aug 01, 2001 at 03:33:50PM -0700, Grover, Andrew wrote:
> Would you mind doing the following:
> 
> 1) Try 2.4.7 patched with the latest ACPI debug version from:
> 
> ftp://download.intel.com/technology/IAPC/acpi/downloads/acpica-linux-debug-2
> 0010717.tar.gz
> 
> ...and send me your dmesg? We can proceed from there. ;-)
> 
> Regards -- Andy
> 
> > From: Eric Buddington 
> > I began to report this bug a couple weeks back, under 
> > 2.4.6-ac3, but left on vacation before
> > capturing and parsing the panic.
