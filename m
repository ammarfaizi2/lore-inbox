Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161045AbWFJW6n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161045AbWFJW6n (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jun 2006 18:58:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161047AbWFJW6n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jun 2006 18:58:43 -0400
Received: from w3.zipcon.net ([209.221.136.4]:44723 "HELO w3.zipcon.net")
	by vger.kernel.org with SMTP id S1161045AbWFJW6n convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jun 2006 18:58:43 -0400
From: Bill Waddington <william.waddington@beezmo.com>
To: linux-kernel@vger.kernel.org
Subject: Re: SATA Conflict with PATA DMA
Date: Sat, 10 Jun 2006 15:58:10 -0700
Message-ID: <r9jm82lm9l4mir6jkfrh7gas3um73tt4rb@4ax.com>
References: <fa.ln8Pe5HNqw60/RjEpl4xhDtmxDg@ifi.uio.no> <fa.foo0W8w4UdiDztK9eBiA9awyAi8@ifi.uio.no> <fa.UjEGyG0y7x3qVLsO0eHpXVza2r8@ifi.uio.no>
In-Reply-To: <fa.UjEGyG0y7x3qVLsO0eHpXVza2r8@ifi.uio.no>
X-Mailer: Forte Agent 3.3/32.846
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 Apr 2006 18:39:20 UTC, in fa.linux.kernel you wrote:

>On Sat, 15 Apr 2006 16:42:22 UTC, in fa.linux.kernel you wrote:
>
>>Esben Stien wrote:
>>> I'm having problems enabling DMA for my PATA HD.
>>> 
>>> hdparm -d1 /dev/hdb reports: 
>>> HDIO_SET_DMA failed: Operation not permitted

>>Disabled combined mode in BIOS.
>
>If only that was possible on my fscking T43.  *sigh*

(for others struggling with this) Per the fix reported at

https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=163418

Updating my T43/FC5 to kernel 2.6.16-1.2122_FC5 and booting
with "combined_mode=libata" gets the DVD drive running at speed
as /dev/scd0 (although there doesn't seem to be any explicit
"dma enabled" indication).

Thanks Jeff et al.

Bill
-- 
William D Waddington
william.waddington@beezmo.com
"Even bugs...are unexpected signposts on
the long road of creativity..." - Ken Burtch

