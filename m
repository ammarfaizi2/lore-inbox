Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270527AbTGNFyy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 01:54:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270539AbTGNFyy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 01:54:54 -0400
Received: from mail.kroah.org ([65.200.24.183]:59018 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S270527AbTGNFyw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 01:54:52 -0400
Date: Sun, 13 Jul 2003 23:09:43 -0700
From: Greg KH <greg@kroah.com>
To: Samium Gromoff <deepfire@ibe.miee.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.5.75] USB missing hotplug events?
Message-ID: <20030714060943.GA20431@kroah.com>
References: <87el0tvgzh.fsf@drakkar.ibe.miee.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87el0tvgzh.fsf@drakkar.ibe.miee.ru>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 14, 2003 at 09:01:54AM +0400, Samium Gromoff wrote:
> the chip is VIA VT6202.
> Linux betelheise 2.5.75 #1 Fri Jul 11 21:05:08 MSD 2003 i686 GNU/Linux
> 
> the USB controller doesn`t even generate interrupts when i insert
> various USB devices, and hence no device gets detected...

Has any USB devices ever worked on this box?
It looks like a PCI interrupt routing issue, not a USB issue.  See the
linux-kernel archives for various ways people try to work around this
problem.

thanks,

greg k-h
