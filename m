Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265294AbUBIRyc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 12:54:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265298AbUBIRy0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 12:54:26 -0500
Received: from dsl-082-083-132-139.arcor-ip.net ([82.83.132.139]:64134 "EHLO
	server1.intern.kubla.de") by vger.kernel.org with ESMTP
	id S265294AbUBIRyW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 12:54:22 -0500
Date: Mon, 9 Feb 2004 18:54:21 +0100
From: Dominik Kubla <dominik@kubla.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Thomas Horsten <thomas@horsten.com>, Arjan van de Ven <arjanv@redhat.com>,
       linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org
Subject: Re: New mailing list for 2.6 Medley RAID (Silicon Image 3112 etc.) BIOS RAID development
Message-ID: <20040209175421.GD1795@intern.kubla.de>
References: <Pine.LNX.4.40.0402091220130.8715-100000@jehova.dsm.dk> <4027BBDE.1090300@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4027BBDE.1090300@pobox.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 09, 2004 at 11:57:02AM -0500, Jeff Garzik wrote:
> Thomas Horsten wrote:
> >My gut feeling is that if it is provided by the BIOS and reliable
> >autodetection is possible, it should be autodetected. Why require the user
> >to discover and supply information that the kernel could easily and
> >reliably find out by itself? Besides, if there is no autodetection, the
> 
> The autodetection will occur, reliably and without additional user 
> information, from initramfs.
> 
> As Arjan said, we are moving this type of stuff out of the kernel.
> 
> 	Jeff

Is there any existing code using initramfs? So far all i have seen is
very incomplete.  I would love to move to initramfs and get rid of
mkinitrd, but too many pieces seem to be still missing...

Regards,
  Dominik Kubla
-- 
The more cordial the buyer's secretary, the greater the odds that the
competition already has the order.
