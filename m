Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751080AbWBFK7l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751080AbWBFK7l (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 05:59:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751078AbWBFK7l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 05:59:41 -0500
Received: from webapps.arcom.com ([194.200.159.168]:7949 "EHLO
	webapps.arcom.com") by vger.kernel.org with ESMTP id S1751082AbWBFK7k
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 05:59:40 -0500
Message-ID: <43E72C1B.8000706@arcom.com>
Date: Mon, 06 Feb 2006 10:59:39 +0000
From: David Vrabel <dvrabel@arcom.com>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Russell King <rmk@arm.linux.org.uk>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: serial: SERIAL_8250_RUNTIME_UARTS must be <= SERIAL_8250_NR_UARTS
References: <43E72479.4020804@arcom.com>
In-Reply-To: <43E72479.4020804@arcom.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 06 Feb 2006 11:04:32.0484 (UTC) FILETIME=[1BA27A40:01C62B0D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Vrabel wrote:
> If SERIAL_8250_RUNTIME_UARTS is > SERIAL_8250_NR_UARTS then more serial
> ports are registered than we've allocated memory for.  Prevent this by
> limiting SERIAL_8250_RUNTIME_UARTS in the serial Kconfig.

Nevermind.  I see Russell has already applied an equivilent patch.

David Vrabel
-- 
David Vrabel, Design Engineer

Arcom, Clifton Road           Tel: +44 (0)1223 411200 ext. 3233
Cambridge CB1 7EA, UK         Web: http://www.arcom.com/
