Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751324AbWCLAFH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751324AbWCLAFH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Mar 2006 19:05:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751334AbWCLAFG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Mar 2006 19:05:06 -0500
Received: from mail.dvmed.net ([216.237.124.58]:5303 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751324AbWCLAFF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Mar 2006 19:05:05 -0500
Message-ID: <441365AC.2040309@pobox.com>
Date: Sat, 11 Mar 2006 19:05:00 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tejun Heo <htejun@gmail.com>
CC: Jiri Slaby <jirislaby@gmail.com>, Andrew Morotn <akpm@osdl.org>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] libata: fix missing classes[] initialization in ata_bus_probe()
References: <20060307021929.754329c9.akpm@osdl.org> <E1FI5tQ-0002kx-00@decibel.fi.muni.cz> <20060311155739.GA23806@htj.dyndns.org>
In-Reply-To: <20060311155739.GA23806@htj.dyndns.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tejun Heo wrote:
> ata_bus_probe() didn't initialize classes[] properly with
> ATA_DEV_UNKNOWN.  As ->probe_reset() is allowed to leave @classes
> alone when no device is present, this results in garbage class values.
> ATM, the only affected driver is ata_piix.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> Cc: Jiri Slaby <jirislaby@gmail.com>

applied to #upstream


