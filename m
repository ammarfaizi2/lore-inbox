Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261976AbUFJQMz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261976AbUFJQMz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jun 2004 12:12:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261914AbUFJQKr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jun 2004 12:10:47 -0400
Received: from mail.kroah.org ([65.200.24.183]:40663 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261939AbUFJQKg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jun 2004 12:10:36 -0400
Date: Thu, 10 Jun 2004 09:04:44 -0700
From: Greg KH <greg@kroah.com>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] Add platform_device_register_simple
Message-ID: <20040610160444.GB31787@kroah.com>
References: <200406090221.24739.dtor_core@ameritech.net> <200406100140.30621.dtor_core@ameritech.net> <200406100142.14861.dtor_core@ameritech.net> <200406100143.53381.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200406100143.53381.dtor_core@ameritech.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 10, 2004 at 01:43:51AM -0500, Dmitry Torokhov wrote:
> 
> ===================================================================
> 
> 
> ChangeSet@1.1767, 2004-06-09 23:58:52-05:00, dtor_core@ameritech.net
>   sysfs: add platform_device_register_simple() that creates a simple
>          platform device that does not manage any resources. Modules
>          using such platform devices can be unloaded without waiting
>          for the device to me released (but any additional resources
>          allocated by module should be freed beforehand).

I have the same objections to this that Russell does.  Also, care to
show me a patch that uses this new interface, so that I can understand
what you are trying to accomplish here?

thanks,

greg k-h
