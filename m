Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263085AbUB0SQZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 13:16:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263084AbUB0SQZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 13:16:25 -0500
Received: from delerium.kernelslacker.org ([81.187.208.145]:60089 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S263085AbUB0SQV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 13:16:21 -0500
Date: Fri, 27 Feb 2004 18:14:55 +0000
From: Dave Jones <davej@redhat.com>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: Greg KH <greg@kroah.com>, Alexander Viro <aviro@redhat.com>,
       "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Sysfs is too restrictive
Message-ID: <20040227181454.GD15016@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Stephen Hemminger <shemminger@osdl.org>, Greg KH <greg@kroah.com>,
	Alexander Viro <aviro@redhat.com>,
	"David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
References: <20040227100541.284fb155@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040227100541.284fb155@dell_ss3.pdx.osdl.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 27, 2004 at 10:05:41AM -0800, Stephen Hemminger wrote:
 >     |   |-- bridge
 >     |   |   |-- forward_delay
 >     |   |   |-- hello_time
 >     |   |   |-- id
 >     |   |   |-- max_age
 >     |   |   |-- port
 >     |   |   |   |-- cost
 >     |   |   |   |-- eth0 -> ../../../eth0
 >     |   |   |   |-- priority
 >     |   |   |   `-- stp
 >     |   |   `-- priority
 >     |   |-- broadcast

Shouldn't you be seeing the other side of the bridge in here too ?
Ie, if br0 is a bridge between eth0 and eth1, how does that fit
your plan ?

		Dave

