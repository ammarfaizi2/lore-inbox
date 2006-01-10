Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030683AbWAJXMK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030683AbWAJXMK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 18:12:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030680AbWAJXMJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 18:12:09 -0500
Received: from [81.2.110.250] ([81.2.110.250]:53135 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S1030466AbWAJXMH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 18:12:07 -0500
Subject: Re: Error handling in LibATA
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: John Treubig <jtreubig@hotmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
In-Reply-To: <BAY101-F102837A76FADACF6F37DBBDF250@phx.gbl>
References: <BAY101-F102837A76FADACF6F37DBBDF250@phx.gbl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 10 Jan 2006 23:15:16 +0000
Message-Id: <1136934917.26976.4.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2006-01-10 at 16:30 -0600, John Treubig wrote:
> I've traced the errors down to the fact that the errors are caught in 
> libata-core.c (ata_qc_timeout).  I'd like to put a call in libata-core.c 


drivers/ide/* doesn't use libata. libata is used by the new PATA/SATA
drivers.

