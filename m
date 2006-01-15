Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750822AbWAOUuq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750822AbWAOUuq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jan 2006 15:50:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750819AbWAOUu0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jan 2006 15:50:26 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:61828 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1750753AbWAOUt7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jan 2006 15:49:59 -0500
Date: Sun, 15 Jan 2006 21:49:47 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Matthew Garrett <mgarrett@chiark.greenend.org.uk>
cc: Ben Collins <bcollins@ubuntu.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/15] sonypi: Enable ACPI events for Sony laptop hotkeys
In-Reply-To: <E1EuRN6-0006Hu-00@chiark.greenend.org.uk>
Message-ID: <Pine.LNX.4.61.0601152149060.4240@yvahk01.tjqt.qr>
References: <0ISL001SM95JWW@a34-mta01.direcway.com> <E1EuRN6-0006Hu-00@chiark.greenend.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Signed-off-by: Ben Collins <bcollins@ubuntu.com>
>
>The "right" way is probably actually to push ACPI hotkey events through
>the input layer (like the Sony code does without this patch), but that's
>currently a bit more awkward to handle in userspace. Since the right
>answer here is clearly "Fix userspace", we probably don't want to be
>merging this.
>

I certainly need this patch though, because it allows me to set the LCD 
brightness via /proc/acpi/sony/brightness.



Jan Engelhardt
-- 
| Alphagate Systems, http://alphagate.hopto.org/
| jengelh's site, http://jengelh.hopto.org/
