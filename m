Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270776AbTGPNxO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 09:53:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270845AbTGPNxO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 09:53:14 -0400
Received: from host-64-213-145-173.atlantasolutions.com ([64.213.145.173]:23429
	"EHLO havoc.gtf.org") by vger.kernel.org with ESMTP id S270776AbTGPNxF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 09:53:05 -0400
Date: Wed, 16 Jul 2003 10:07:53 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Error using mii-tool on 2.6-test, 2.4 okay
Message-ID: <20030716140753.GA5628@gtf.org>
References: <20030716125213.GA6582@rivenstone.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030716125213.GA6582@rivenstone.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 16, 2003 at 08:52:14AM -0400, Joseph Fannin wrote:
> 
> 	I've just switched another of my boxes over to 2.6-test; so
> far, I've had only one problem -- attempts to force the network card
> (tulip-based) to full-duplex with mii-tool fail with:
> 
> SIOCGMIIPHY on 'eth0' failed: Operation not supported
> no MII interfaces found
> 
>        The same command works fine in 2.4.  This the packaged mii-tool
> in Debian unstable (1.9 2000/04/28).  I've tried rebuilding the
> package on another very similar machine, but the error remains.
> Ethtool also doesn't work, but I'm not sure it did with 2.4 and this
> card either.

Get the latest mii-tool (possibly from cvs).  The one in Debian
unstable doesn't use the official MII ioctls.


> Are mii-tool and CONFIG_MII mutually exclusive?

No.

	Jeff



