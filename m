Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932079AbVKLFIu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932079AbVKLFIu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 00:08:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932078AbVKLFIt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 00:08:49 -0500
Received: from mail.dvmed.net ([216.237.124.58]:26510 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932076AbVKLFIt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 00:08:49 -0500
Message-ID: <437578CD.1080501@pobox.com>
Date: Sat, 12 Nov 2005 00:08:29 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org, netdev@vger.kernel.org,
       jonathan@buzzard.org.uk, tlinux-users@linux.toshiba-dme.co.jp,
       Jaroslav Kysela <perex@suse.cz>
Subject: Re: [RFC: 2.6 patch] remove ISA legacy functions
References: <20051107200336.GH3847@stusta.de> <20051110042857.38b4635b.akpm@osdl.org> <20051111021258.GK5376@stusta.de> <20051110182443.514622ed.akpm@osdl.org> <20051111201849.GP5376@stusta.de> <20051111202005.GQ5376@stusta.de> <20051111203601.GR5376@stusta.de> <20051112045216.GY5376@stusta.de>
In-Reply-To: <20051112045216.GY5376@stusta.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> This patch removes the ISA legacy functions that are deprecated since 
> kernel 2.4 and that aren't available on all architectures.
> 
> The 7 drivers that were still using this obsolete API are now marked
> as BROKEN.
> 
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

it's not valid to mark working drivers broken, IMO.

Mark them x86-only, perhaps.

	Jeff



