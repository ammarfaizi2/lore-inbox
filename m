Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261613AbULTTDB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261613AbULTTDB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 14:03:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261615AbULTTDB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 14:03:01 -0500
Received: from utopia.booyaka.com ([206.168.112.107]:22166 "EHLO
	utopia.booyaka.com") by vger.kernel.org with ESMTP id S261613AbULTTCq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 14:02:46 -0500
Date: Mon, 20 Dec 2004 12:02:45 -0700 (MST)
From: Paul Walmsley <paul@booyaka.com>
To: Juergen Botz <jurgen@botz.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Thinkpad T42, keyboard sometimes hosed when waking from sleep
In-Reply-To: <cpl6n2$ivd$1@sea.gmane.org>
Message-ID: <Pine.LNX.4.44.0412201147230.24228-100000@utopia.booyaka.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Dec 2004, Juergen Botz wrote:

> I have a new IBM Thinkpad T42, FC3 with all updates, stock
> 2.6.9-1.681_FC3 kernel + iwp2200 driver (0.13).  Everyone once
> in a while when I wake from ACPI S3 sleep my keyboard is hosed...
> the first key I press starts rapidly auto-repeating, which can't
> be stopped, and pressing any key produces either no visible
> action or some other character (not the one normally on that
> key) which also auto repeats madly.

I'm also seeing this behavior on an HP Omnibook 6000 laptop running Red
Hat's latest release of 2.6.9 - same kernel version as the above poster.  
Upon resume, the keyboard malfunctions but the touchpad works fine. It
happens with either ACPI or APM.  (I did notice that during ACPI resume,
the machine spits out several error messages from atkbd.c to the kernel
message log - when I've next got serial console access, I'll post them 
here.)

This behavior happens about 2/3rds of the time that the machine comes out
of suspend.  It did not occur with any of the 2.6 kernels that shipped
with Fedora Core 2 before FC3 came out.


- Paul

