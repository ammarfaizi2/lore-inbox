Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262315AbTHTXla (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 19:41:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262334AbTHTXla
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 19:41:30 -0400
Received: from mail.kroah.org ([65.200.24.183]:28604 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262315AbTHTXl3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 19:41:29 -0400
Date: Wed, 20 Aug 2003 16:41:14 -0700
From: Greg KH <greg@kroah.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org, andrew.grover@intel.com, len.brown@intel.com
Subject: Re: [patch] remove mount_root_failed_msg()
Message-ID: <20030820234114.GA5518@kroah.com>
References: <20030820232045.GA25921@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030820232045.GA25921@gtf.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 20, 2003 at 07:20:45PM -0400, Jeff Garzik wrote:
> 
> * overall, I disagree with adding messages like this.  The number one
>   bug report, by far, for networking drivers is ACPI-related (no
>   interrupts delivered).  You don't see me adding "boot with acpi=off"
>   messages to the net subsystem.

It's the number one bug report for USB drivers too :(

It has gotten smaller, and I would hope that is due to advances in the
ACPI code, but they still do crop up quite frequently.

thanks,

greg k-h
