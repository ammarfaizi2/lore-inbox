Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262499AbUCLUS1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 15:18:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262424AbUCLUST
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 15:18:19 -0500
Received: from smtp.netcabo.pt ([212.113.174.9]:21113 "EHLO smtp.netcabo.pt")
	by vger.kernel.org with ESMTP id S262499AbUCLUQy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 15:16:54 -0500
Date: Fri, 12 Mar 2004 20:00:20 +0000
From: backblue <backblue@netcabo.pt>
To: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: a7n8x-x & i2c
Message-Id: <20040312200020.1d92f676.backblue@netcabo.pt>
In-Reply-To: <20040312003135.GA26958@kroah.com>
References: <20040310185047.454779fc.backblue@netcabo.pt>
	<20040312003135.GA26958@kroah.com>
X-Mailer: Sylpheed version 0.9.7claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 12 Mar 2004 20:00:39.0859 (UTC) FILETIME=[B1606030:01C4086C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

No i dont have nothing of that enable! all debug options are disable, should a7n8x-x work with lm_sensors? sensors-detect says that dont founds any chip's in my machine... but it finds nforce2 SMBus.

On Thu, 11 Mar 2004 16:31:35 -0800
Greg KH <greg@kroah.com> wrote:

> On Wed, Mar 10, 2004 at 06:50:47PM +0000, backblue wrote:
> > Hello,
> > 
> > I have compiled 2.6.3, with i2c suporte for my chipset "nforce2" to
> > the board asus a7n8x-x, but, it crashes my box all the time, dont know
> > why!  But it only crashes after login and a couple of minutes
> > working...  any one know womething about this?
> 
> What is the oops reported?
> 
> Do you have any of the CONFIG_I2C_DEBUG_* options enabled?  If so,
> please do not, as that was causing a few oopses.  All of them are fixed
> in the latest -mm release.
> 
> thanks,
> 
> greg k-h
