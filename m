Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261838AbVBUEuz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261838AbVBUEuz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Feb 2005 23:50:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261850AbVBUEuz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Feb 2005 23:50:55 -0500
Received: from falcon.csc.calpoly.edu ([129.65.242.5]:14472 "EHLO
	falcon.csc.calpoly.edu") by vger.kernel.org with ESMTP
	id S261838AbVBUEuo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Feb 2005 23:50:44 -0500
Date: Sun, 20 Feb 2005 20:50:39 -0800 (PST)
From: Joshua Hudson <jwhudson@hornet.csc.calpoly.edu>
To: Pedro Venda <pjvenda@arrakis.net.dhis.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Help - really messed up kernel
In-Reply-To: <421946A3.4090609@arrakis.dhis.org>
Message-ID: <Pine.GSO.4.44.0502202048150.23851-100000@hornet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thinks for trying. I finally found the problem myself.
There is some incompatability between syslinux 2.10 and kernel 2.6.10
Using lilo on the first floppy fixed the problem

Oh, and no I am *not* using an initrd. I am using the old paramiters
that cause the kernel to load the ramdisk after it boots.

