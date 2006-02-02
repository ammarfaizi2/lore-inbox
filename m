Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423363AbWBBHsO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423363AbWBBHsO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 02:48:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423362AbWBBHsO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 02:48:14 -0500
Received: from host85.viapvt.sk ([195.28.64.85]:40122 "EHLO mailx.netax.sk")
	by vger.kernel.org with ESMTP id S1423358AbWBBHsM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 02:48:12 -0500
Message-ID: <43E1B93A.5000603@slovanet.net>
Date: Thu, 02 Feb 2006 08:48:10 +0100
From: Jozef Kutej <jozef.kutej@slovanet.net>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: calling bios interrupt
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

Can someone help me solve my problem with on board watch dog timer that 
need to call bios interrupt? Here's how to update watch dog timer.

mov ax,6f02h
mov bl, 30	;number of seconds
int 15h

How can i do this in kernel so that i can write wdt driver?

Thank you.

Jozef Kutej.
