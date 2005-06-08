Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261377AbVFHQNb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261377AbVFHQNb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 12:13:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261379AbVFHQLf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 12:11:35 -0400
Received: from mail.kroah.org ([69.55.234.183]:14476 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261345AbVFHQKJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 12:10:09 -0400
Date: Wed, 8 Jun 2005 09:09:54 -0700
From: Greg KH <greg@kroah.com>
To: Abhay_Salunke@Dell.com
Cc: dtor_core@ameritech.net, linux-kernel@vger.kernel.org, akpm@osdl.org,
       Matt_Domsch@Dell.com, ranty@debian.org
Subject: Re: [patch 2.6.12-rc3] modifications in firmware_class.c to support nohotplug
Message-ID: <20050608160954.GB1122@kroah.com>
References: <367215741E167A4CA813C8F12CE0143B0283F1FC@ausx2kmpc115.aus.amer.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <367215741E167A4CA813C8F12CE0143B0283F1FC@ausx2kmpc115.aus.amer.dell.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 08, 2005 at 11:04:09AM -0500, Abhay_Salunke@Dell.com wrote:
> > I think it would be better if you just have request_firmware and
> > request_firmware_nowait accept timeout parameter that would override
> > default timeout in firmware_class. 0 would mean use default,
> > MAX_SCHED_TIMEOUT - wait indefinitely.
> 
> But we still need to avoid hotplug being invoked as we need it be a
> manual process.

No, hotplug can happen just fine (it happens loads of times today for
things that people don't care about.)

thanks,

greg k-h
