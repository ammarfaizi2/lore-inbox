Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261872AbTLCVXU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 16:23:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261885AbTLCVXU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 16:23:20 -0500
Received: from mail.kroah.org ([65.200.24.183]:10937 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261872AbTLCVXR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 16:23:17 -0500
Date: Wed, 3 Dec 2003 13:21:58 -0800
From: Greg KH <greg@kroah.com>
To: "Collins, Bernard F. (Skip)" <Bernard.Collins@jhuapl.edu>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: Visor USB hang
Message-ID: <20031203212158.GA12724@kroah.com>
References: <E37E01957949D611A4C30008C7E691E20915BBC3@aples3.dom1.jhuapl.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E37E01957949D611A4C30008C7E691E20915BBC3@aples3.dom1.jhuapl.edu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 03, 2003 at 03:44:47PM -0500, Collins, Bernard F. (Skip) wrote:
> I am running 2.4.23 on a RedHat 9 system. Whenever I try to sync my Visor
> Deluxe, the system hangs/freezes soon after I press the sync button on my
> cradle. Trying to find the cause of the problem, I preloaded the usbserial
> and visor modules with "debug=1". Nothing obviously wrong appears in the
> logs. The last message before the system freezes is a usb-uhci.c interrupt
> message.

Can you show the log with that enabled?

What happens if you use the uhci.o module instead of usb-uhci.o?

thanks,

greg k-h
