Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261947AbUFJQKl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261947AbUFJQKl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jun 2004 12:10:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261943AbUFJQKj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jun 2004 12:10:39 -0400
Received: from mail.kroah.org ([65.200.24.183]:38359 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261932AbUFJQKc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jun 2004 12:10:32 -0400
Date: Thu, 10 Jun 2004 09:02:50 -0700
From: Greg KH <greg@kroah.com>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/3] Allow registering device without taking bus lock
Message-ID: <20040610160250.GA31787@kroah.com>
References: <200406090221.24739.dtor_core@ameritech.net> <200406100143.53381.dtor_core@ameritech.net> <200406100145.01599.dtor_core@ameritech.net> <200406100146.25471.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200406100146.25471.dtor_core@ameritech.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 10, 2004 at 01:46:23AM -0500, Dmitry Torokhov wrote:
> ChangeSet@1.1769, 2004-06-10 00:10:02-05:00, dtor_core@ameritech.net
>   sysfs: provide means for adding and removing devices to a bus without
>          taking bus' semaphore so devices can be added/removed from
>          driver's probe() and remove() methods.

Ick, no, sorry, I will not take this.

For now (2.6), do what others do and add the devices from another
thread, or somthing else.

We will revisit this in 2.7 to make it a sane solution.

Sorry,

greg k-h
