Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265669AbUAMW1v (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 17:27:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265776AbUAMW1u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 17:27:50 -0500
Received: from palrel12.hp.com ([156.153.255.237]:32985 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S265669AbUAMW1r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 17:27:47 -0500
Date: Tue, 13 Jan 2004 14:27:45 -0800
To: Stephen Hemminger <shemminger@osdl.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, "David S. Miller" <davem@redhat.com>,
       netdev@oss.sgi.com,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.6.X] SIOCSIFNAME wilcard suppor & name validation
Message-ID: <20040113222745.GA12147@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <20040112234332.GA1785@bougret.hpl.hp.com> <20040113142204.0b41403b.shemminger@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040113142204.0b41403b.shemminger@osdl.org>
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 13, 2004 at 02:22:04PM -0800, Stephen Hemminger wrote:
> Here is an enhanced version of the previous patch.
> It adds both the wildcard support that Jean did, and validation of network
> device names.

	Excellent. Your patch looks much cleaner.

> It doesn't check the error return from class_device_rename because
> that will not fail unless object or name are null.

	I was not 100% sure if this would remain true.

	Thanks !

	Jean
