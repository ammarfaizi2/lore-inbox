Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263114AbUCYQOe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 11:14:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263215AbUCYQOe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 11:14:34 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:10667 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263114AbUCYQOd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 11:14:33 -0500
Message-ID: <40630559.3040105@pobox.com>
Date: Thu, 25 Mar 2004 11:14:17 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: mike.miller@hp.com
CC: axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: cciss updates [1 of 2]
References: <20040325153631.GA4456@beardog.cca.cpqcorp.net>
In-Reply-To: <20040325153631.GA4456@beardog.cca.cpqcorp.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mikem@beardog.cca.cpqcorp.net wrote:
> Please consider this change for inclusion in the 2.4 kernel.
> 
> This change is required to support the new MSA30 storage enclosure.
> If you do a SCSI inquiry to a SATA disk bad things happen. This patch prevents 
> the inquiry from going to SATA disks.


I 'ack' both of those patches, but am still curious:  wouldn't you want 
to either (a) simulate an inquiry page via ATA's identify device or (b) 
allow userspace to issue identify device?

	Jeff



