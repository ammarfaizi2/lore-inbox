Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262498AbULCXas@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262498AbULCXas (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 18:30:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262507AbULCXar
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 18:30:47 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:4802 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262498AbULCXan (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 18:30:43 -0500
Date: Fri, 3 Dec 2004 15:29:45 -0800
From: Greg KH <greg@kroah.com>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: maneesh@in.ibm.com, akpm@osdl.org, chrisw@osdl.org,
       linux-kernel@vger.kernel.org, viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: [Fake patch] Make sysfs_dirent.s_type an unsigned short
Message-ID: <20041203232945.GA24168@kroah.com>
References: <200412030356.iB33uSg03460@adam.yggdrasil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200412030356.iB33uSg03460@adam.yggdrasil.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 02, 2004 at 07:56:28PM -0800, Adam J. Richter wrote:
> 	Here is a fake patch against my heavily hacked sysfs tree
> to change sysfs_dirent.s_type from an int to an unsigned short.
> It appears next to another unsigned short (s_mode), so it should
> save 4 bytes per sysfs node.

Note, Maneesh is currently moving across continents so he's going to be
away from email for a while.  I'm queuing up most of these changes to go
in after 2.6.10 is out, as most of them look good.

thanks,

greg k-h
