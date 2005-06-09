Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262469AbVFIVMx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262469AbVFIVMx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 17:12:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262473AbVFIVMx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 17:12:53 -0400
Received: from dspnet.fr.eu.org ([213.186.44.138]:20754 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S262469AbVFIVMo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 17:12:44 -0400
Date: Thu, 9 Jun 2005 23:12:42 +0200
From: Olivier Galibert <galibert@pobox.com>
To: Andi Kleen <ak@muc.de>
Cc: James Ketrenos <jketreno@linux.intel.com>, Jeff Garzik <jgarzik@pobox.com>,
       Netdev list <netdev@oss.sgi.com>,
       kernel list <linux-kernel@vger.kernel.org>,
       "James P. Ketrenos" <ipw2100-admin@linux.intel.com>
Subject: Re: ipw2100: firmware problem
Message-ID: <20050609211242.GA30319@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	Andi Kleen <ak@muc.de>, James Ketrenos <jketreno@linux.intel.com>,
	Jeff Garzik <jgarzik@pobox.com>, Netdev list <netdev@oss.sgi.com>,
	kernel list <linux-kernel@vger.kernel.org>,
	"James P. Ketrenos" <ipw2100-admin@linux.intel.com>
References: <20050608142310.GA2339@elf.ucw.cz> <42A723D3.3060001@linux.intel.com> <m1is0nvdkw.fsf@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1is0nvdkw.fsf@muc.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 09, 2005 at 03:56:15PM +0200, Andi Kleen wrote:
> I guess at some point we will need a file system in there, but - oops -
> we already have one, dont we? :)

Well, you could put .config in it too.

Frankly, a filesystem that:
- can be somehow linked with vmlinux and not separate like an initrd

- editable post vmlinux-linking

- gives files that can be accessed from request_firmware, acpi and
  friends even rather early in the boot process (i.e. well before any
  userland is allowed to exist)

- accessible post-boot through mounting of a special fs and/or /proc or something

would be quite useful.

  OG.
