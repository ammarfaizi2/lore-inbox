Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262416AbUKQQnL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262416AbUKQQnL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 11:43:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262407AbUKQQlR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 11:41:17 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:15267 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S262401AbUKQQik (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 11:38:40 -0500
Date: Wed, 17 Nov 2004 17:38:34 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix missing includes for isdn diversion
In-Reply-To: <20041102142602.402316ef.akpm@osdl.org>
Message-ID: <Pine.LNX.4.53.0411171728430.25776@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andrew Morton wrote:

>> # File:  isdn_divert.diff
>> # Class: missing prototype addition
>> #
>> # Adds #include <linux/interrupt.h> to resolve missing calls to cli(),
>> # sti() and restore_flags().
>>
>> Signed-off by: Jan Engelhardt <jengelh@linux01.gwdg.de>
>>
>> diff -dpru linux-2.6.4-52/drivers/isdn/divert/divert_init.c
>
>This appears to be against a 2.6.4 kernel, yes?

Yes, but I would not have posted it if it was not applicable to <current>.

>The problem might have been fixed in the intervening months.  Please
>confirm that the bug still exists in 2.6.10-rc1 and if so, send an updated
>patch.
>
>Thanks.

Anyway, for bulletproofness, I've taken a 2.6.10-rc2 try and tried a --dry-run.
The patch utility ran fine, so it's now confirmed that it applies to
2.6.10-rc2 too.

Maybe this is in relation to the other thread "[PATCH] dss1_divert ISDN module
compile fix for kernel" ?




Jan Engelhardt
-- 
Gesellschaft für Wissenschaftliche Datenverarbeitung
Am Fassberg, 37077 Göttingen, www.gwdg.de
