Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264060AbTDWOhA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 10:37:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264061AbTDWOhA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 10:37:00 -0400
Received: from smtp-out1.iol.cz ([194.228.2.86]:5597 "EHLO smtp-out1.iol.cz")
	by vger.kernel.org with ESMTP id S264060AbTDWOg7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 10:36:59 -0400
Date: Wed, 23 Apr 2003 16:47:05 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: Fix SWSUSP & !SWAP
Message-ID: <20030423144705.GA2823@elf.ucw.cz>
References: <20030423135100.GA320@elf.ucw.cz> <Pine.GSO.4.21.0304231631560.1343-100000@vervain.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0304231631560.1343-100000@vervain.sonytel.be>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Swsusp without swap makes no sense, but leads to compilation
> > failure. This fixes it. Please apply,
> 
> Just wondering, what about MMU-less machines?

Ugh... Currently: no we can't do that. We are happy to suspend/resume
on i386 ;-).
								Pavel

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
