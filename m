Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261928AbVCBBDA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261928AbVCBBDA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 20:03:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261968AbVCBBDA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 20:03:00 -0500
Received: from rrcs-24-123-59-149.central.biz.rr.com ([24.123.59.149]:6183
	"EHLO galon.ev-en.org") by vger.kernel.org with ESMTP
	id S261928AbVCBBC6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 20:02:58 -0500
Message-ID: <422510BA.1010305@ev-en.org>
Date: Wed, 02 Mar 2005 01:02:50 +0000
From: Baruch Even <baruch@ev-en.org>
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Paul Dickson <dickson@permanentmail.com>
Cc: linux-os@analogic.com, linux-kernel@vger.kernel.org
Subject: Re: Network speed Linux-2.6.10
References: <Pine.LNX.4.61.0503011426180.578@chaos.analogic.com> <20050301175143.04cbbe64.dickson@permanentmail.com>
In-Reply-To: <20050301175143.04cbbe64.dickson@permanentmail.com>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Dickson wrote:
> On Tue, 1 Mar 2005 14:29:24 -0500 (EST), linux-os wrote:
>>Intel NIC e100 device driver. Two identical machines.
>>Private network, no other devices. Connected using a Netgear switch.
>>Test data is the same thing sent from memory on one machine
>>to a discard server on another, using TCP/IP SOCK_STREAM.
>>
>>If I set both machines to auto-negotiation OFF and half duplex,
>>I get about 9 to 9.5 megabytes/second across the private wire
>>network.
>>
>>If I set one machine to full duplex and the other to half-duplex
>>I get 10 to 11 megabytes/second transfer across the network,
>>regardless of direction.
>>
>>If I set both machines to auto-negotiation OFF and full duplex,
>>I get 300 to 400 kilobytes/second regardless of the direction.
> 
> Might this be related to the broken BicTCP implementations in the 2.6.6+
> kernels?  A fix was added around 2.6.11-rc3 or 4.

Unlikely, the problem with BIC would have shown itself only at high 
speeds over long latency links, not over a lan connection.

Baruch
