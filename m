Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261171AbVAaNQC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261171AbVAaNQC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 08:16:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261191AbVAaNQB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 08:16:01 -0500
Received: from mail.suse.de ([195.135.220.2]:14011 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261171AbVAaNPv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 08:15:51 -0500
Message-ID: <41FE2F86.90905@suse.de>
Date: Mon, 31 Jan 2005 14:15:50 +0100
From: Hannes Reinecke <hare@suse.de>
Organization: SuSE Linux AG
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.2) Gecko/20040906
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@suse.cz>
Subject: Re: [PATCH] Resume from initramfs
References: <41FE24F5.5070906@suse.de> <1107175398.25905.32.camel@tyrosine>
In-Reply-To: <1107175398.25905.32.camel@tyrosine>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Garrett wrote:
> One thing - if swsusp_read() fails (eg, due to there not actually being
> a suspend image), the processes will have been frozen but not woken up.
> The failure path in software_resume needs to call thaw_processes before
> exiting.
> 
You are, of course, correct. Will be fixing it.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke			hare@suse.de
SuSE Linux AG				S390 & zSeries
Maxfeldstraße 5				+49 911 74053 688
90409 Nürnberg				http://www.suse.de
