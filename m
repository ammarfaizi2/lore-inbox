Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965023AbWHQOYP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965023AbWHQOYP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 10:24:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965030AbWHQOYB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 10:24:01 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:390 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S965023AbWHQOXo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 10:23:44 -0400
Subject: Re: JMicron SATA/IDE and 2.6.18-rc4 fails to detect CDROM
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: mikepolniak <mikpolniak@adelphia.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060817140115.GA3808@debamd64>
References: <20060817140115.GA3808@debamd64>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 17 Aug 2006 15:44:26 +0100
Message-Id: <1155825866.15195.97.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Iau, 2006-08-17 am 10:01 -0400, ysgrifennodd mikepolniak:
> Using 2.6.18-rc4 and CONFIG_SCSI_SATA_AHCI=m, fails to detect ide cdrom.

rc4 support for the PATA ports on the jmicron is broken. Please try
rc4-mm1 if you need it. A patch went to Greg a while ago so it should I
hope be fixed in rc5

Alan
