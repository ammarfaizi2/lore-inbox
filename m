Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271272AbTHCS1E (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Aug 2003 14:27:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271278AbTHCS1D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Aug 2003 14:27:03 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:58793 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S271272AbTHCS1A
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Aug 2003 14:27:00 -0400
Message-ID: <3F2D53E8.7070700@pobox.com>
Date: Sun, 03 Aug 2003 14:26:48 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Jurgen Kramer <gtm.kramer@inter.nl.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.22pre10-ac1: ICH5 SATA missing in action
References: <1059934705.2789.8.camel@paragon.slim>
In-Reply-To: <1059934705.2789.8.camel@paragon.slim>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jurgen Kramer wrote:
> With 2.4.22pre10-ac1 the SATA part of the ICH5 is no longer
> found or recognized. With a plain 2.4.22pre3 (last 2.4.22pre I tested)
> it was working properly.


The -ac tree defaults to using CONFIG_SCSI_ATA and CONFIG_SCSI_ATA_PIIX 
for ICH5 SATA support.

	Jeff



