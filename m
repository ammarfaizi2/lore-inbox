Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262050AbULLMgi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262050AbULLMgi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Dec 2004 07:36:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262061AbULLMgg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Dec 2004 07:36:36 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:4830 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262050AbULLMgc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Dec 2004 07:36:32 -0500
Subject: Re: PCI IRQ problems -- update
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jim Paris <jim@jtan.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20041211200248.GA22393@jim.sh>
References: <20041211173538.GA21216@jim.sh>
	 <1102783555.7267.37.camel@localhost.localdomain>
	 <20041211200248.GA22393@jim.sh>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1102851153.1371.12.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 12 Dec 2004 11:32:34 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2004-12-11 at 20:02, Jim Paris wrote:
> OK, I see.  Does Linux leave it in legacy mode even when using a
> specific driver like piix?  Do you know how I can get more information
> on the state of it at boot, to see if BIOS did leave it in legacy
> mode? 

We have to take it as it comes. Vendors sometimes don't even both wiring
INTA so bad things occur if you change the mode of the chip. Plus a lot
of IDE devices are buggy in this area (as you notied with ICH3M).


