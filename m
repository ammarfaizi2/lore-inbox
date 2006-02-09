Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965248AbWBIRGv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965248AbWBIRGv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 12:06:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965247AbWBIRGv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 12:06:51 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:45008 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S965241AbWBIRGn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 12:06:43 -0500
Date: Thu, 9 Feb 2006 18:06:37 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Con Kolivas <kernel@kolivas.org>
cc: gcoady@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6 vs 2.4, ssh terminal slowdown
In-Reply-To: <200602081335.18256.kernel@kolivas.org>
Message-ID: <Pine.LNX.4.61.0602091806100.30108@yvahk01.tjqt.qr>
References: <j4kiu1de3tnck2bs7609ckmt89pfoumlbe@4ax.com>
 <200602081335.18256.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> grant@deltree:~$ time grep -v 192\.168\. /var/log/apache/access_log| cut
>> -c-95 ...
>
>What happens if you add "| cat" on the end of your command?
>
Do you think it's the new pipe buffering thing? (Introduced 2.6.10-.12, 
don't remember exactly)


Jan Engelhardt
-- 
