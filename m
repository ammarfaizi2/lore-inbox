Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751354AbWARGtn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751354AbWARGtn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 01:49:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751356AbWARGtn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 01:49:43 -0500
Received: from mail01.hansenet.de ([213.191.73.61]:16590 "EHLO
	webmail.hansenet.de") by vger.kernel.org with ESMTP
	id S1751354AbWARGtm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 01:49:42 -0500
Message-ID: <43CDE526.5060904@web.de>
Date: Wed, 18 Jan 2006 07:50:14 +0100
From: Marcus Hartig <m.f.h@web.de>
User-Agent: Thunderbird 1.5 (X11/20060112)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.15 libata/sata_sil: not detecting my SATA dvd-drive.
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > In kernel 2.6.13.4, I'm able to acces my dvd-drive by changing these
 > lines in include/linux/libata.h

Enable SATA ATAPI in drivers/scsi/libata-core.c now. Line 81 with 
2.6.16-rc1:

int atapi_enabled = 1;

and recompile.

Marcus
