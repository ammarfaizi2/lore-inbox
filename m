Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750814AbWH3KFq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750814AbWH3KFq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 06:05:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750767AbWH3KFq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 06:05:46 -0400
Received: from www.osadl.org ([213.239.205.134]:50094 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1750814AbWH3KFp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 06:05:45 -0400
Subject: Re: [RFC] Simple userspace interface for PCI drivers
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060830062338.GA10285@kroah.com>
References: <20060830062338.GA10285@kroah.com>
Content-Type: text/plain
Date: Wed, 30 Aug 2006 12:09:26 +0200
Message-Id: <1156932566.29250.119.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-08-29 at 23:23 -0700, Greg KH wrote:
> So, here's the code.  I think it does a bit too much all at once, but it
> is an example of how this can be done.  This is working today in some
> industrial environments, successfully handling hardware controls of very
> large and scary machines.  So it is possible to use this interface to
> successfully build your own laser wielding robot, all from userspace,
> allowing you to keep your special-secret-how-to-control-the-laser
> algorithm closed source if you so desire.
> 
> In looking at the proposed kevent interface, I think a few things in
> this proposed interface can be dropped in favor of using kevents
> instead, but I haven't looked at the latest version of that code to make
> sure of this.

Yeah, that makes sense.

> And the name is a bit ackward, anyone have a better suggestion?
> 
> Thomas has also promised to come up with some userspace code that uses
> this interface to show how to use it, but seems to have forgotten.
> Consider this a reminder :)

Yup. I pinged the customer again to get the "non-secret" :) parts
published.

	tglx


