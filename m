Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262072AbTLLVeS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 16:34:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262078AbTLLVeR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 16:34:17 -0500
Received: from mail.kroah.org ([65.200.24.183]:56973 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262072AbTLLVeM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 16:34:12 -0500
Date: Fri, 12 Dec 2003 13:31:48 -0800
From: Greg KH <greg@kroah.com>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: udev for dummies
Message-ID: <20031212213148.GA24643@kroah.com>
References: <20031211221604.GA2939@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031211221604.GA2939@werewolf.able.es>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 11, 2003 at 11:16:04PM +0100, J.A. Magallon wrote:
> Hi all...
> 
> I am starting to use 2.6, and I really would like to use udev.
> But I can't find a doc about how to move from taditional heavily
> populated /dev to new method.
> 
> Any pointer ?

Did you read the README in udev's package?

Anyway, I don't really recommend using udev for management of your /dev
at this moment in time.  In order to do this we need some more
intregration of udev into the early boot process.  People are working on
this, but it will be a bit of time before it works properly, sorry.

thanks,

greg k-h
