Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264363AbTH2Agg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 20:36:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264368AbTH2Agg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 20:36:36 -0400
Received: from vitelus.com ([64.81.243.207]:12221 "EHLO vitelus.com")
	by vger.kernel.org with ESMTP id S264363AbTH2Agf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 20:36:35 -0400
Date: Thu, 28 Aug 2003 17:34:26 -0700
From: Aaron Lehmann <aaronl@vitelus.com>
To: "Bryan O'Sullivan" <bos@keyresearch.com>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [ANNOUNCE] netplug, a daemon that handles network cables getting plugged in and out
Message-ID: <20030829003426.GF12249@vitelus.com>
References: <1062105712.12285.78.camel@serpentine.internal.keyresearch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1062105712.12285.78.camel@serpentine.internal.keyresearch.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 28, 2003 at 02:21:52PM -0700, Bryan O'Sullivan wrote:
> Netplug is a daemon that responds to network cables being plugged in or
> out by bringing a network interface up or down.  This is extremely
> useful for DHCP-managed systems that move around a lot, such as laptops
> and systems in cluster environments.
> 
> For more details and download instructions, see the netplug homepage:
> http://www.red-bean.com/~bos/

Thank you, thank you, thank you. I was just thinking today how
annoying it is that whenever I boot up my laptop, dhclient runs and tries
to get an IP address on the ethernet interface until it's ^C'd. Since
I often use the Ethernet interface this is not a bad default, but dhclient
can't even realize on its own that there's no cable plugged in.
