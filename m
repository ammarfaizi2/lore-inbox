Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966246AbWKTRbQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966246AbWKTRbQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 12:31:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966256AbWKTRbQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 12:31:16 -0500
Received: from mail.kroah.org ([69.55.234.183]:5838 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S966246AbWKTRbP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 12:31:15 -0500
Date: Mon, 20 Nov 2006 09:31:16 -0800
From: Greg KH <gregkh@suse.de>
To: Jiri Slaby <jirislaby@gmail.com>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: kobject_add failed with -EEXIST
Message-ID: <20061120173116.GA27160@suse.de>
References: <4561E290.7060100@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4561E290.7060100@gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2006 at 06:14:56PM +0100, Jiri Slaby wrote:
> Hi!
> 
> Does anybody have some clue, what's wrong with the attached module?
> Kernel complains when the module is insmoded second time (DRIVER_DEBUG
> enabled):

I just tried this with 2.6.19-rc6 and it worked just fine, no problems.
Perhaps you have some userspace program keeping the
/sys/class/cls_class/cls_device/ files open?

thanks,

greg k-h
