Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264799AbUEERyH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264799AbUEERyH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 May 2004 13:54:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264796AbUEERyG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 May 2004 13:54:06 -0400
Received: from mail.kroah.org ([65.200.24.183]:63659 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264799AbUEERx5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 May 2004 13:53:57 -0400
Date: Wed, 5 May 2004 09:16:29 -0700
From: Greg KH <greg@kroah.com>
To: Daniel Moyne <dmoyne@tiscali.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [bug kernel 2.6 / USB / SCSI] report
Message-ID: <20040505161629.GA23860@kroah.com>
References: <200405051318.50204.dmoyne@tiscali.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200405051318.50204.dmoyne@tiscali.fr>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 05, 2004 at 01:18:49PM +0200, Daniel Moyne wrote:
> USB :
> 
> - the only way to get my USB printer recognized is to use the following 
> modules (from lsmod) :
> usblp                  12256  0
> ehci-hcd               24196  0
> uhci-hcd               29104  0
> usbcore                99132  6 hid,usblp,ehci-hcd,uhci-hcd
> 
> and set the following "append" option in lilo :
> 	append="devfs=mount noapic resume=/dev/hda5"
> what is relevant here is obviously the "noapic" option ("apic=ht" works fine 
> for kernel 2.4.x)

Ok, there's no problem there.

> - ohci does not work !

Do you have OHCI hardware?  If not, why would you expect it to work?

thanks,

greg k-h
