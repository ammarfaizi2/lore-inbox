Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263062AbTDYBT5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 21:19:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263057AbTDYBT5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 21:19:57 -0400
Received: from smtp2.clear.net.nz ([203.97.37.27]:3520 "EHLO
	smtp2.clear.net.nz") by vger.kernel.org with ESMTP id S263062AbTDYBTz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 21:19:55 -0400
Date: Fri, 25 Apr 2003 13:19:17 +1200
From: Nigel Cunningham <ncunningham@clear.net.nz>
Subject: Re: Fix SWSUSP & !SWAP
In-reply-to: <b8a2le$p88$1@cesium.transmeta.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <1051233557.1663.37.camel@laptop-linux>
Organization: 
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.2.2
Content-type: text/plain
Content-transfer-encoding: 7bit
References: <1051182797.2250.10.camel@laptop-linux>
 <Pine.GSO.4.21.0304241335210.19942-100000@vervain.sonytel.be>
 <b8a2le$p88$1@cesium.transmeta.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

They are synced, the journal is just not truncated.

Regards,

Nigel

On Fri, 2003-04-25 at 13:22, H. Peter Anvin wrote: 
> Shouldn't we be syncing them all before the suspend anyway, to
> minimize corruption in case the user chooses to mount the filesystem
> *without* resuming (think a dual-boot configuration.)  This would be
> another application for the "supersync" operation that was discussed
> at OLS 2002 -- a need for an operation which not only flushes all
> blocks to disk but also forces the journal to be replayed and
> truncated.
> 
> 	-hpa



-- 
Nigel Cunningham
495 St Georges Road South, Hastings 4201, New Zealand

Be diligent to present yourself approved to God as a workman who does
not need to be ashamed, handling accurately the word of truth.
	-- 2 Timothy 2:14, NASB.

