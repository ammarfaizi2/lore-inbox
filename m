Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267182AbUBMUez (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 15:34:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267199AbUBMUez
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 15:34:55 -0500
Received: from mail.kroah.org ([65.200.24.183]:14507 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S267182AbUBMUev (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 15:34:51 -0500
Date: Fri, 13 Feb 2004 12:33:37 -0800
From: Greg KH <greg@kroah.com>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sys_device_[un]register() are not syscalls
Message-ID: <20040213203337.GA14048@kroah.com>
References: <20040213080753.12af00bd.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040213080753.12af00bd.rddunlap@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 13, 2004 at 08:07:53AM -0800, Randy.Dunlap wrote:
> 
> 
> sys_xyz() names in Linux are all syscalls... except for
> sys_device_register() and sys_device_unregister().
> 
> This patch renames them so that the sys_ namespace is once
> again used only by syscalls.
> 
> Comments?

Ah, that makes sense.  I'll add it to my patches to send off once 2.6.3
is out.

thanks,

greg k-h
