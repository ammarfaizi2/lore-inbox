Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261294AbUJ3Tzi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261294AbUJ3Tzi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 15:55:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261295AbUJ3Tzh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 15:55:37 -0400
Received: from mail.kroah.org ([69.55.234.183]:37003 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261294AbUJ3Tzf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 15:55:35 -0400
Date: Sat, 30 Oct 2004 12:40:07 -0700
From: Greg KH <greg@kroah.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Problem with hotplug functions
Message-ID: <20041030194007.GA13907@kroah.com>
References: <1099153682.16247.30.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1099153682.16247.30.camel@pegasus>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 30, 2004 at 06:28:02PM +0200, Marcel Holtmann wrote:
> 
> The hotplug function of hotplug_ops get called, but afterwards its
> values are overwritten by the sequence number. Is this correct or do I
> made a thinking mistake?

You are correct, there's another thread on lkml about proposed patches
to solve this bug.  The last one from Kay looks like the final version
I'll send to Linus tomorrow.

Sorry about this.

thanks,

greg k-h
