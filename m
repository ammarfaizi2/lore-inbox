Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750714AbWBEUxK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750714AbWBEUxK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Feb 2006 15:53:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750718AbWBEUxK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Feb 2006 15:53:10 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:7102 "EHLO
	aria.kroah.org") by vger.kernel.org with ESMTP id S1750714AbWBEUxJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Feb 2006 15:53:09 -0500
Date: Sun, 5 Feb 2006 12:53:13 -0800
From: Greg KH <greg@kroah.com>
To: s.schmidt@avm.de
Cc: linux-kernel@vger.kernel.org, opensuse-factory@opensuse.org, kkeil@suse.de
Subject: Re: 2.6.16 serious consequences / GPL_EXPORT_SYMBOL / USB drivers of major vendor excluded
Message-ID: <20060205205313.GA9188@kroah.com>
References: <200601200904.00389.dazzle.digital@gmail.com> <OF7A130C3D.76EBAB24-ONC125710A.003AC847-C125710A.005A1B7D@avm.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF7A130C3D.76EBAB24-ONC125710A.003AC847-C125710A.005A1B7D@avm.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 03, 2006 at 05:24:10PM +0100, s.schmidt@avm.de wrote:
> on January 15th / major change in USB subsystem and GPL_EXPORT_SYMBOL
> declaration
> Greg Kroah-Hartman added a Patch to kernel 2.6.15-git12, which
> substantially changed the USB system.

Have you asked Greg why he did this?

Have you asked what the other alternatives are?

You do know about usbfs/libusb that allows you to write USB drivers in
userspace that can go at the full speed of the USB bus?  Why not redo
your code to take advantage of this?  If you do that, the extra bonus is
that your drivers will also work on the BSDs and possibly Windows with
no changes needed (I think libusb works on Windows...)

> This mail is not intended to provoke a discussion of open vs closed source.
> The only intention of this mail is to make you aware of the consequences of
> such a decision.

I was not aware of your drivers, but now that you have informed me of
them, I am willing to work with you to figure out how to resolve this
issue.

thanks,

greg k-h
