Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937417AbWLDV7e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937417AbWLDV7e (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 16:59:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937420AbWLDV7e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 16:59:34 -0500
Received: from iriserv.iradimed.com ([69.44.168.233]:59174 "EHLO iradimed.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S937417AbWLDV7c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 16:59:32 -0500
Message-ID: <45749A63.1040009@cfl.rr.com>
Date: Mon, 04 Dec 2006 17:00:03 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5.0.8 (Windows/20061025)
MIME-Version: 1.0
To: Bernard Pidoux <pidoux@ccr.jussieu.fr>
CC: linux-kernel@vger.kernel.org
Subject: Re: Why SCSI module needed for PCI-IDE ATA only disks ?
References: <457492B2.2050107@ccr.jussieu.fr>
In-Reply-To: <457492B2.2050107@ccr.jussieu.fr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 04 Dec 2006 21:59:47.0233 (UTC) FILETIME=[8363D910:01C717EF]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.6.1039-14854.000
X-TM-AS-Result: No--6.510100-5.000000-31
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bernard Pidoux wrote:
> I am asking why need to compile the following modules while I do not
> have any SCSI device ?

Because your hardware is driven by a libata based driver.  This means it 
is a scsi bus driver and thus, requires mod_scsi and the scsi disk 
module to access disks on the bus.


