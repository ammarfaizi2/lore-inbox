Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262329AbUFJSSy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262329AbUFJSSy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jun 2004 14:18:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262337AbUFJSSy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jun 2004 14:18:54 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:17814 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262329AbUFJSSp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jun 2004 14:18:45 -0400
Message-ID: <40C8A5F6.3030002@pobox.com>
Date: Thu, 10 Jun 2004 14:18:30 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kevin Tarr <kev_tarr@yahoo.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Serial ATA (SATA) on Linux status report (2.6.x mainstream plan
 for AHCI and iswraid??)
References: <20040610155740.81227.qmail@web90109.mail.scd.yahoo.com>
In-Reply-To: <20040610155740.81227.qmail@web90109.mail.scd.yahoo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kevin Tarr wrote:
> I have a machine running with an ICH6R Intel chipset.
> I've been watching the LKML for info on my ICH6R
> chipset's AHCI mode support. It has been a month since
> the last SATA status report so I figured I'd write to
> ask: Does anyone know when the preliminary AHCI driver
> will be integrated into libata mainline? If so I
> assume it will be a patch against the 2.6.x kernel?

My deadline for integrating AHCI into Red Hat's kernel is measured in 
days, if that gives you an indication ;-)


> Also, are there plans to release a version of iswraid 
> for ICH6R against 2.6.x?

Have you tried Carl-Daniel's raiddetect?  2.6 does not include 
ataraid-based drivers, preferred a Device Mapper (DM) approach instead.

	Jeff


