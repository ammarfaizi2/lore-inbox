Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261977AbVCBAvu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261977AbVCBAvu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 19:51:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261982AbVCBAvt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 19:51:49 -0500
Received: from orb.pobox.com ([207.8.226.5]:7564 "EHLO orb.pobox.com")
	by vger.kernel.org with ESMTP id S261977AbVCBAvs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 19:51:48 -0500
Date: Tue, 1 Mar 2005 17:51:43 -0700
From: Paul Dickson <dickson@permanentmail.com>
To: linux-os@analogic.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Network speed Linux-2.6.10
Message-Id: <20050301175143.04cbbe64.dickson@permanentmail.com>
In-Reply-To: <Pine.LNX.4.61.0503011426180.578@chaos.analogic.com>
References: <Pine.LNX.4.61.0503011426180.578@chaos.analogic.com>
X-Mailer: Sylpheed version 1.9.3 (GTK+ 2.4.14; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Mar 2005 14:29:24 -0500 (EST), linux-os wrote:

> Intel NIC e100 device driver. Two identical machines.
> Private network, no other devices. Connected using a Netgear switch.
> Test data is the same thing sent from memory on one machine
> to a discard server on another, using TCP/IP SOCK_STREAM.
> 
> If I set both machines to auto-negotiation OFF and half duplex,
> I get about 9 to 9.5 megabytes/second across the private wire
> network.
> 
> If I set one machine to full duplex and the other to half-duplex
> I get 10 to 11 megabytes/second transfer across the network,
> regardless of direction.
> 
> If I set both machines to auto-negotiation OFF and full duplex,
> I get 300 to 400 kilobytes/second regardless of the direction.

Might this be related to the broken BicTCP implementations in the 2.6.6+
kernels?  A fix was added around 2.6.11-rc3 or 4.

	-Paul

