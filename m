Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262030AbTIRSYD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Sep 2003 14:24:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262037AbTIRSYD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Sep 2003 14:24:03 -0400
Received: from mail.kroah.org ([65.200.24.183]:16816 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262030AbTIRSYC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Sep 2003 14:24:02 -0400
Date: Thu, 18 Sep 2003 11:24:07 -0700
From: Greg KH <greg@kroah.com>
To: John Cherry <cherry@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: IA32 - 27 New warnings
Message-ID: <20030918182407.GB1846@kroah.com>
References: <200309180623.h8I6N3F4007504@cherrypit.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200309180623.h8I6N3F4007504@cherrypit.pdx.osdl.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 17, 2003 at 11:23:03PM -0700, John Cherry wrote:
> drivers/usb/class/usb-midi.h:150: warning: `usb_midi_ids' defined but not used

Hm, what compiler version are you using to get this warning?
This should not be happening (the usb_midi_ids are used in the
MODULE_DEVICE_TABLE() macro to export the info to userspace), and I
can't duplicate the warning here with gcc versions 3.3.1 or 2.96 (Red
Hat rawhide and Red Hat 7.3 respectively)

thanks,

greg k-h
