Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751154AbWEZQyS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751154AbWEZQyS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 12:54:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751156AbWEZQyS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 12:54:18 -0400
Received: from science.horizon.com ([192.35.100.1]:59968 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S1751154AbWEZQyR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 12:54:17 -0400
Date: 26 May 2006 12:54:16 -0400
Message-ID: <20060526165416.30979.qmail@science.horizon.com>
From: linux@horizon.com
To: linux-kernel@vger.kernel.org, marc@perkel.com
Subject: Re: AMD AM2 Compatibility?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Just wondering if the Linux kernel is compatible with the new AM2 socket 
> processors and motherboards yet? Or is this too bleeding edge?

The only difference between AM2 and Socket 939/940 processors is DDR2
memory support.  So initializing the memory controller is a bit different,
but the BIOS does that before even looking for a boot loader, so Linux
shouldn't even notice the change.

The only place compatibility issues could show up is if you use the new
nForce5 chipset.  The built-in devices might work differently, or might
not be recognized, but I doubt nvidia did anything too severe; they
probably want generic Microsoft operating systems to work.
