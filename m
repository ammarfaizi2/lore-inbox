Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161062AbWJKOJv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161062AbWJKOJv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 10:09:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030408AbWJKOJv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 10:09:51 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:28679 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1030406AbWJKOJu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 10:09:50 -0400
Date: Wed, 11 Oct 2006 10:09:43 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Paolo Abeni <paolo.abeni@email.it>
cc: gregkh@suse.de, <linux-kernel@vger.kernel.org>,
       <linux-usb-devel@lists.sourceforge.net>
Subject: Re: [linux-usb-devel] [PATCH] usbmon: add binary interface
In-Reply-To: <1160557065.9547.12.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.44L0.0610111008570.6870-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Oct 2006, Paolo Abeni wrote:

> From: Paolo Abeni <paolo.abeni@email.it>
> 
> A binary interface is added to usbmon. For each USB bus present on the host system a new file is added to the debugfs directory, in the form "usb%db".
> 
> USB records are stored in a liked list, alike current text interface implementation, so most code is shared from binary and text interface.
> This code has been moved into mon_commom.c.
> 
> The binary interface support resizing the amount of USB data stored in each record via an ioctl method.

You forgot to update Documentation/usb/usbmon.txt.

Alan Stern

