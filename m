Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263573AbTLIJLC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 04:11:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266167AbTLIJLB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 04:11:01 -0500
Received: from mail.kroah.org ([65.200.24.183]:736 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263573AbTLIJKz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 04:10:55 -0500
Date: Tue, 9 Dec 2003 01:08:15 -0800
From: Greg KH <greg@kroah.com>
To: Xavier Bestel <xavier.bestel@free.fr>
Cc: Witukind <witukind@nsbm.kicks-ass.org>, recbo@nishanet.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: udev sysfs docs Re: State of devfs in 2.6?
Message-ID: <20031209090815.GA2681@kroah.com>
References: <200312081536.26022.andrew@walrond.org> <20031208154256.GV19856@holomorphy.com> <3FD4CC7B.8050107@nishanet.com> <20031208233755.GC31370@kroah.com> <20031209061728.28bfaf0f.witukind@nsbm.kicks-ass.org> <20031209075619.GA1698@kroah.com> <1070960433.869.77.camel@nomade>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1070960433.869.77.camel@nomade>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 09, 2003 at 10:00:34AM +0100, Xavier Bestel wrote:
> Le mar 09/12/2003 à 08:56, Greg KH a écrit :
> >   A:  That is correct.  If you really require this functionality, then
> >       use devfs.  There is no way that udev can support this, and it
> >       never will.
> 
> That's something I don't understand: I thought that with a well
> configured hotplug+udev system, you'll never have to worry about loading
> drivers on device-node open() because all drivers should be auto-loaded
> and all device-nodes should be auto-created.
> 
> Am I wrong ?

No, you are correct.  That's why I'm not really worried about this, and
I don't think anyone else should be either.

thanks,

greg k-h
