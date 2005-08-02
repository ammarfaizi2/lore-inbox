Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261542AbVHBOJd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261542AbVHBOJd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 10:09:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261539AbVHBOHJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 10:07:09 -0400
Received: from mail08.syd.optusnet.com.au ([211.29.132.189]:24244 "EHLO
	mail08.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261541AbVHBOFo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 10:05:44 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Avuton Olrich <avuton@gmail.com>
Subject: Re: [patch] i386 dynamic ticks 2.6.13-rc4 (code reordered)
Date: Wed, 3 Aug 2005 00:05:13 +1000
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org, tony@atomide.com,
       tuukka.tikkanen@elektrobit.com, ck@vds.kolivas.org
References: <200508021443.55429.kernel@kolivas.org> <3aa654a40508020701e605533@mail.gmail.com>
In-Reply-To: <3aa654a40508020701e605533@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508030005.13731.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Aug 2005 00:01, Avuton Olrich wrote:
> OK, I rolled my own patch, 2.6.13-rc4-ck1-reiser4+this patch and it
> appears to be running on my desktop Asus A7N8X very well:
>
> I am running with Local APIC/IO-APIC/APIC Timer and forceapic. Time
> does not appear to be running slow, and I do not appear to have a slow
> boot.

Great!

> sbh@rocket ~ $ cat /sys/devices/system/timer/timer0/dyn_tick_state
> suitable:       1
> enabled:        1
> using APIC:     1

Tony as an aside, I notice I get much lower Hz values (less than half) on my 
P4 if I'm running without using APIC although everything appears to run 
stable in either configuration. Is this expected behaviour?

Cheers,
Con
