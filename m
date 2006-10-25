Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423157AbWJYJsH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423157AbWJYJsH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 05:48:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423158AbWJYJsH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 05:48:07 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:50084 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1423157AbWJYJsE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 05:48:04 -0400
Date: Wed, 25 Oct 2006 11:47:57 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Michael (Micksa) Slade" <micksa@knobbits.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Inspiron 6000 and CPU power saving
Message-ID: <20061025094757.GA7658@elf.ucw.cz>
References: <4532EBE2.6090709@knobbits.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4532EBE2.6090709@knobbits.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I recently discovered that my Inspiron 6000 uses about 50% more power 
> idling in linux than in windows XP.  This means its battery life is 
> about 2/3 of what it could/should be.
> 
> I guessed it might be the CPU, and did some tests.  The results strongly 
> suggest as much.  These are the results I got for power consumption in 
> various situations.
> 
> linux idle at 800MHz: 27W        
> linux idle at 1600MHz: 36W        
> linux raytracing at 800: 30W
> linux raytracing at 1600: 42W 
> 
> windows idle (presumably 800MHz): 16W
> windows raytracing (presumably 1600MHz): 36W
> 
> I've tried ubuntu dapper and ubuntu edgy, and RIP 10 (rescue disk) and 
> BBC 2.1 (rescue disk), and they all appear to have the same issue.  The 
> machine's BIOS has no APM so I can't try it for comparison.

Let me guess, UHCI? Remove usb modules, and measure again.

For details, see 8hours on your lap presentation, linked from
http://www.livejournal.com/~pavelmachek .

								Pavel
