Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263107AbTLADWR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Nov 2003 22:22:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263172AbTLADWR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Nov 2003 22:22:17 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:21969 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263107AbTLADWQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Nov 2003 22:22:16 -0500
Message-ID: <3FCAB3D8.8020001@pobox.com>
Date: Sun, 30 Nov 2003 22:22:00 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Joe Blow <joeblow341@hotmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Promise 20378 + 2.6.0-test10 + libata patch 1
References: <BAY7-F79JONRxh4e7Ob0001b5ff@hotmail.com>
In-Reply-To: <BAY7-F79JONRxh4e7Ob0001b5ff@hotmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joe Blow wrote:
> 
> I have applied the libata patch 1 to kernel 2.6.0-test10.  I can now see 
> the PDC RAID controller via the hardware browser, but I can not see any 
> of the attatched PATA drives.  (I do not have any SATA drives).
> 
> I have tried the controller set to RAID and IDE.  I can not locate the 
> attached PATA drives in /proc/ide or /proc/scsi, nor does the hardware 
> browser see them.  I #define ATA_VERBOSE_DEBUG and I did not find any 
> addtional output in dmesg.
> 
> Does this driver not support PATA drives attatched to this controller?


Nope, libata Promise driver only supports Serial ATA.

	Jeff



