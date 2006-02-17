Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964833AbWBQQJh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964833AbWBQQJh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 11:09:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964913AbWBQQJh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 11:09:37 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:18091 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S964833AbWBQQJg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 11:09:36 -0500
Date: Fri, 17 Feb 2006 17:09:28 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Takashi Iwai <tiwai@suse.de>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH trivial] Fix "value computed not used" warnings
In-Reply-To: <s5h7j7xbu0v.wl%tiwai@suse.de>
Message-ID: <Pine.LNX.4.61.0602171703300.27452@yvahk01.tjqt.qr>
References: <s5h7j7xbu0v.wl%tiwai@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>Fixes for annoying gcc-4.1 compile warnings "value computed not used".
>Simply cast to void.
>
Iiih, casts.

The thing is defined as
	#define r1()                    (in_p(1) & 0xff)
so what do we call it for - does inb do more than just reading, like 
resetting the ioport to 0?




Jan Engelhardt
-- 
