Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932250AbWFOFJk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932250AbWFOFJk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 01:09:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751238AbWFOFJk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 01:09:40 -0400
Received: from xenotime.net ([66.160.160.81]:6337 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1750860AbWFOFJj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 01:09:39 -0400
Date: Wed, 14 Jun 2006 22:12:23 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: George Nychis <gnychis@cmu.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: cdrom support with thinkpad x6 ultrabay
Message-Id: <20060614221223.8a74e991.rdunlap@xenotime.net>
In-Reply-To: <4490E776.7080000@cmu.edu>
References: <4490E776.7080000@cmu.edu>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Jun 2006 00:52:06 -0400 George Nychis wrote:

> Hi,
> 
> I am looking for support somewhere in the kernel for my thinkpad x6
> ultrabay's cdrom drive.  Whenever I attach the ultrabay it picks up the
> extra usb ports, seems to pick up the ethernet port, but it fails to
> pick up anything about the dvd/cd-writer.  Nothing shows up in dmesg
> about the drive at all... anyone know what I might need in the kernel?
> I am using 2.6.17-rc6

I'm not sure, but you may need the dock station driver patches
that are in -mm.  You could try 2.6.17-rc6-mm2 ...

---
~Randy
