Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261693AbTISTIt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Sep 2003 15:08:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261691AbTISTIt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Sep 2003 15:08:49 -0400
Received: from mail.kroah.org ([65.200.24.183]:16066 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261693AbTISTIm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Sep 2003 15:08:42 -0400
Date: Fri, 19 Sep 2003 12:06:28 -0700
From: Greg KH <greg@kroah.com>
To: Jan Rychter <jan@rychter.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.22 USB problem (uhci)
Message-ID: <20030919190628.GI6624@kroah.com>
References: <m2znh1pj5z.fsf@tnuctip.rychter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m2znh1pj5z.fsf@tnuctip.rychter.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 18, 2003 at 08:10:48PM -0700, Jan Rychter wrote:
> Upon disconnecting an USB mouse from a 2.4.22, I get
> 
>   uhci.c: efe0: host controller halted. very bad
> 
> and subsequently, the machine keeps on spinning in ACPI C2 state, never
> going into C3, as it should (since the mouse is the only USB device).
> 
> If afterwards I do 'rmmod uhci; modprobe uhci', then the machine starts
> using the C3 state again.

If you use the usb-uhci driver, does it also do this?

thanks,

greg k-h
