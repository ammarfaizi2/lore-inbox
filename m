Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992915AbWJUKYp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992915AbWJUKYp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Oct 2006 06:24:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992917AbWJUKYo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Oct 2006 06:24:44 -0400
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:41617 "EHLO
	smtp.drzeus.cx") by vger.kernel.org with ESMTP id S2992916AbWJUKYo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Oct 2006 06:24:44 -0400
Message-ID: <4539F568.2030506@drzeus.cx>
Date: Sat, 21 Oct 2006 12:24:40 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5.0.7 (X11/20061008)
MIME-Version: 1.0
To: Jeff Garzik <jeff@garzik.org>, oakad@yahoo.com,
       Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drivers/{mmc,misc}: handle PCI errors on resume
References: <20061011214809.GA21756@havoc.gtf.org> <20061013080035.GD28654@flint.arm.linux.org.uk>
In-Reply-To: <20061013080035.GD28654@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> On Wed, Oct 11, 2006 at 05:48:09PM -0400, Jeff Garzik wrote:
>> Since pci_enable_device() is one of the first things called in the
>> resume step, take the minimalist approach and return immediately, if
>> pci_enable_device() fails during resume.
> 
> NAK, for the same reason as for drivers/serial.
> 

So what would be the prudent course of action in this case?

Rgds
-- 
     -- Pierre Ossman

  Linux kernel, MMC maintainer        http://www.kernel.org
  PulseAudio, core developer          http://pulseaudio.org
  rdesktop, core developer          http://www.rdesktop.org
