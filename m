Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264867AbTLKJYO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 04:24:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264868AbTLKJYO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 04:24:14 -0500
Received: from mail.kroah.org ([65.200.24.183]:23786 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264867AbTLKJYL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 04:24:11 -0500
Date: Thu, 11 Dec 2003 00:51:23 -0800
From: Greg KH <greg@kroah.com>
To: Carlos Puchol <cpg@nospam.rocketmail.com.puchol.com.kroah.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test11 oops galore: visor sync, cd/dvd burning
Message-ID: <20031211085123.GA5102@kroah.com>
References: <20031210111151.GA6104@rome.puchol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031210111151.GA6104@rome.puchol.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 10, 2003 at 03:11:51AM -0800, Carlos Puchol wrote:
> hi, i updated a fedora core 1 system with arjanv's kernel
> and i keep on getting oopses.
> 
> [1.] One line summary of the problem:
> 
> multiple oops while transferring a file to a visor connected vis usb.

Known bug, please apply the usb-serial patch sent to Linus today, and
the kobject.c patch and sysfs patch a few days ago (these are still
being finalized) in order to fix this problem.

thanks,

greg k-h
