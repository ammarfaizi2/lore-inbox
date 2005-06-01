Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261439AbVFAPrC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261439AbVFAPrC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 11:47:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261432AbVFAPp3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 11:45:29 -0400
Received: from mxout1.netvision.net.il ([194.90.9.20]:60869 "EHLO
	mxout1.netvision.net.il") by vger.kernel.org with ESMTP
	id S261439AbVFAPoM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 11:44:12 -0400
Date: Wed, 01 Jun 2005 19:17:45 +0300
From: Sasha Khapyorsky <sashak@smlink.com>
Subject: Re: problem with ALSA ane intel modem driver
In-reply-to: <20050531233712.7b782c6c@laptop>
To: Marcin Bis <marcin.bis@gmail.com>
Cc: linux-kernel@vger.kernel.org
Mail-followup-to: Marcin Bis <marcin.bis@gmail.com>,
 linux-kernel@vger.kernel.org
Message-id: <20050601161745.GB29436@sashak.softier.local>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
References: <200505280716.46688.cijoml@volny.cz>
 <20050528154736.3ab2550a@laptop> <s5h64x0x2pc.wl@alsa2.suse.de>
 <20050531233712.7b782c6c@laptop>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 23:37 Tue 31 May     , Marcin Bis wrote:
> Non working device.
> 
> Semaphore warning is fixed in ALSA CVS (but i still get NO DIALTONE/NO
> CARRIER error for this modem).

It is likely not a driver problem, but modem sw (slmodem I guess) -
the device dma should work for 'NO DIALTONE'.
For sure drop please output of
'cat /proc/asound/card1/codec97#0/mc97#1-1' .

Sasha.
