Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264257AbUACV4u (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jan 2004 16:56:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264267AbUACV4u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jan 2004 16:56:50 -0500
Received: from mail.kroah.org ([65.200.24.183]:36233 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264257AbUACV4t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jan 2004 16:56:49 -0500
Date: Sat, 3 Jan 2004 13:56:46 -0800
From: Greg KH <greg@kroah.com>
To: Witukind <witukind@nsbm.kicks-ass.org>
Cc: "J.A. Magallon" <jamagallon@able.es>, linux-kernel@vger.kernel.org,
       linux-hotplug-devel@lists.sourceforge.net
Subject: Re: udev - please help me to understand
Message-ID: <20040103215646.GE11061@kroah.com>
References: <microsoft-free.87r7yiinaj.fsf@eicq.dnsalias.org> <20040102202316.GD4992@kroah.com> <20040103010010.GA14823@werewolf.able.es> <20040103135433.09eb97b7.witukind@nsbm.kicks-ass.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040103135433.09eb97b7.witukind@nsbm.kicks-ass.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 03, 2004 at 01:54:33PM +0100, Witukind wrote:
> On Sat, 3 Jan 2004 02:00:10 +0100
> "J.A. Magallon" <jamagallon@able.es> wrote: 
> > IE, I want a working and race free devfs, and this is udev.
> 
> Well udev != devfs. I think it's two different ways to solve a same problem.
> What I wonder now is why do we need both /proc and sysfs?

procfs is for process information.
sysfs is for system information.  Slowly, over time, things that are
currently in procfs will be moving to sysfs.

thanks,

greg k-h
