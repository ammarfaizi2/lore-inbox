Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315179AbSHMMFs>; Tue, 13 Aug 2002 08:05:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315198AbSHMMFs>; Tue, 13 Aug 2002 08:05:48 -0400
Received: from p508EF753.dip.t-dialin.net ([80.142.247.83]:29571 "EHLO
	oscar.local.net") by vger.kernel.org with ESMTP id <S315179AbSHMMFs>;
	Tue, 13 Aug 2002 08:05:48 -0400
Date: Tue, 13 Aug 2002 14:09:26 +0200
From: Patrick Mau <mau@oscar.prima.de>
To: k0rd <k0rd@mindwaynetworks.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: statistics for aliased interfaces?
Message-ID: <20020813120926.GA16829@oscar.dorf.de>
Reply-To: Patrick Mau <mau@oscar.prima.de>
References: <Pine.LNX.4.44.0208121258010.16226-100000@akasha.kan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0208121258010.16226-100000@akasha.kan>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 12, 2002 at 12:59:09PM -0400, k0rd wrote:
> Hi.
> We need to monitor bandwidth on aliased (ethx:x) interfaces..
> Is there a way to get the kernel to report statistics on these types of 
> interfaces?

Hi,

currently this is not possible. Packets are counted by the device
driver. An aliased interface is just another name for the interface,
but it uses the same hardware.

You can setup iptable rules to count traffic generated for the
IP addresses of you alias interfaces.

That's what I did. If someone has a better idea, please tell me.
FreeBSD can do traffic accounting for virtual network interfaces.

cheers,
Patrick
