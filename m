Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967412AbWK2PU7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967412AbWK2PU7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 10:20:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967413AbWK2PU7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 10:20:59 -0500
Received: from jdi.jdi-ict.nl ([82.94.239.5]:5848 "EHLO jdi.jdi-ict.nl")
	by vger.kernel.org with ESMTP id S967412AbWK2PU7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 10:20:59 -0500
Date: Wed, 29 Nov 2006 16:20:49 +0100 (CET)
From: Igmar Palsenberg <i.palsenberg@jdi-ict.nl>
X-X-Sender: igmar@jdi.jdi-ict.nl
To: linux-kernel@vger.kernel.org
cc: erich@areca.com.tw
Subject: Re: 2.6.16.32 stuck in generic_file_aio_write()
In-Reply-To: <Pine.LNX.4.58.0611291329060.18799@jdi.jdi-ict.nl>
Message-ID: <Pine.LNX.4.58.0611291619001.11584@jdi.jdi-ict.nl>
References: <Pine.LNX.4.58.0611291329060.18799@jdi.jdi-ict.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.1.12 (jdi.jdi-ict.nl [127.0.0.1]); Wed, 29 Nov 2006 16:20:50 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

A followup. It crashed again, giving me :

arcmsr0: scsi id=0 lun=0 ccb='0xf7c984e0' poll command abort successfully
end_request: I/O error, dev sda, sector 3724719

and

sd 0:0:0:0: rejecting I/O to offline device
about 15k times.

I'll see if I can upgrade the RAID driver.



	Igmar


-- 
Igmar Palsenberg
JDI ICT

Zutphensestraatweg 85
6953 CJ Dieren
Tel: +31 (0)313 - 496741
Fax: +31 (0)313 - 420996
The Netherlands

mailto: i.palsenberg@jdi-ict.nl
