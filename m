Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269435AbTGJQ1Z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 12:27:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269462AbTGJQ1Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 12:27:25 -0400
Received: from storm.he.net ([64.71.150.66]:62871 "HELO storm.he.net")
	by vger.kernel.org with SMTP id S269435AbTGJQ0m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 12:26:42 -0400
Date: Thu, 10 Jul 2003 09:41:22 -0700
From: Greg KH <greg@kroah.com>
To: Michael Frank <mflt1@micrologica.com.hk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.74 CONFIG_USB_SERIAL_CONSOLE gone?
Message-ID: <20030710164121.GA12055@kroah.com>
References: <200307101453.57857.mflt1@micrologica.com.hk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200307101453.57857.mflt1@micrologica.com.hk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 10, 2003 at 02:53:57PM +0800, Michael Frank wrote:
> Tried to config usb serial console on 2.5.74 but it's no more configurable.
> 
> Searched the tree and these are the only references

CONFIG_USB has to be set to Y and CONFIG_USB_SERIAL has to be set to Y
to be able to select this config option.

Do you have those options selected?

And do you _really_ want to use CONFIG_USB_SERIAL_CONSOLE?  It's pretty
useless for the most part :)

thanks,

greg k-h
