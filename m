Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262449AbTJNUt1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 16:49:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262470AbTJNUt0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 16:49:26 -0400
Received: from mail.kroah.org ([65.200.24.183]:43220 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262449AbTJNUtW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 16:49:22 -0400
Date: Tue, 14 Oct 2003 13:48:39 -0700
From: Greg KH <greg@kroah.com>
To: "Daheriya, Adarsh" <Adarsh.Daheriya@fci.com>
Cc: "Murray, Scott" <scott_murray@stream.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: Hot Swap - Resource Allocation Problem.
Message-ID: <20031014204839.GD17026@kroah.com>
References: <903E17B6FF22A24C96B4E28C2C0214D70104BDD5@sr-bng-exc01.int.tsbu.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <903E17B6FF22A24C96B4E28C2C0214D70104BDD5@sr-bng-exc01.int.tsbu.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 14, 2003 at 06:18:04PM +0530, Daheriya, Adarsh wrote:
> > hi Scott,
> > 
> > i am using your hot swap driver for one of our boards here. I have
> > back-ported the driver to 2.4.18 kernel.

For 2.4, I think that Scott had a patch that would require the user to
reserve pci resources at boot time to solve this problem.

See the linux pci hotplug devel mailing list archives for the patch and
a description of how to get this to work on 2.4.

Hope this helps,

greg k-h
