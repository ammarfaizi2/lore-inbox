Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268007AbUHEWXF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268007AbUHEWXF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 18:23:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268032AbUHEWUC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 18:20:02 -0400
Received: from mail.tpgi.com.au ([203.12.160.61]:40162 "EHLO mail.tpgi.com.au")
	by vger.kernel.org with ESMTP id S268006AbUHEWPE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 18:15:04 -0400
Subject: Re: What PM should be and do (Was Re: Solving suspend-level
	confusion)
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Greg KH <greg@kroah.com>
Cc: David Brownell <david-b@pacbell.net>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Oliver Neukum <oliver@neukum.org>, Pavel Machek <pavel@suse.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@digitalimplant.org>
In-Reply-To: <20040805181925.GB30543@kroah.com>
References: <20040730164413.GB4672@elf.ucw.cz>
	 <200408031928.08475.david-b@pacbell.net> <1091588163.5225.77.camel@gaston>
	 <200408032030.41410.david-b@pacbell.net>
	 <1091594872.3191.71.camel@laptop.cunninghams>
	 <20040805181925.GB30543@kroah.com>
Content-Type: text/plain
Message-Id: <1091744073.2597.15.camel@laptop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Fri, 06 Aug 2004 08:14:34 +1000
Content-Transfer-Encoding: 7bit
X-TPG-Antivirus: Passed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Fri, 2004-08-06 at 04:19, Greg KH wrote:
> On Wed, Aug 04, 2004 at 02:47:52PM +1000, Nigel Cunningham wrote:
> > - support for telling what class of device a driver is handling (I'm
> > particularly interested in keeping the keyboard, screen and storage
> > devices alive while suspending).
> 
> You can see that info today from userspace by looking in
> /sys/class/input, /sys/class/graphics, and /sys/block

Does this apply to all devices, and how do I tell it 'programmatically'?
Ie, is the class an element in a struct somewhere?

Regards,

Nigel

