Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261910AbTDKXNj (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 19:13:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261867AbTDKXNj (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 19:13:39 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:21713 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S261910AbTDKXNd (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Apr 2003 19:13:33 -0400
Date: Fri, 11 Apr 2003 16:27:29 -0700
From: Greg KH <greg@kroah.com>
To: Kronos <kronos@kronoz.cjb.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add i2c-viapro.c
Message-ID: <20030411232729.GA4539@kroah.com>
References: <20030411193216.GA9505@dreamland.darkstar.lan> <20030411195415.GN1821@kroah.com> <20030411213946.GA2401@dreamland.darkstar.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030411213946.GA2401@dreamland.darkstar.lan>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Ok. I deleted the  array of struct sd (supported devices)  and moved the
> base field into pci_device_id->driver_data, sd.hstcfg was always 0xD2 so
> I defaulted  the static variable  smb_cf_hstcfg to this  value. It still
> works ;)

Looks good, I've applied this and will send it out.

thanks,

greg k-h
