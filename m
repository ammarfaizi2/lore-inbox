Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261789AbVBTKZa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261789AbVBTKZa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Feb 2005 05:25:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261777AbVBTKZa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Feb 2005 05:25:30 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:51729 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261789AbVBTKZV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Feb 2005 05:25:21 -0500
Date: Sun, 20 Feb 2005 10:25:16 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Dominik Brodowski <linux@dominikbrodowski.net>,
       =?iso-8859-1?Q?David_H=E4rdeman?= <david@2gen.com>,
       linux-kernel@vger.kernel.org
Subject: Re: IBM Thinkpad G41 PCMCIA problems
Message-ID: <20050220102516.E9509@flint.arm.linux.org.uk>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.net>,
	=?iso-8859-1?Q?David_H=E4rdeman?= <david@2gen.com>,
	linux-kernel@vger.kernel.org
References: <20050220092208.GA12738@hardeman.nu> <20050220092659.A9509@flint.arm.linux.org.uk> <20050220095211.GB12738@hardeman.nu> <20050220102059.GA17462@isilmar.linta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050220102059.GA17462@isilmar.linta.de>; from linux@dominikbrodowski.net on Sun, Feb 20, 2005 at 11:20:59AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 20, 2005 at 11:20:59AM +0100, Dominik Brodowski wrote:
> > Is the hole between 0x36f6fa000 and 0x3f700000?
> > 
> > And what would be the proper way of fixing it (assuming that IBM won't 
> > issue a fixed BIOS)?
> 
> passing "reserve=0x3f6fa000,0x600" as kernel boot option. Please also post
> /proc/iomem for further debugging, especially if this didn't help.

You're missing a zero in the length. 8)

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
