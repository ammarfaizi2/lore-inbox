Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261943AbTKCJkc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Nov 2003 04:40:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261947AbTKCJkb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Nov 2003 04:40:31 -0500
Received: from gw-ca43-e0.camline.com ([193.149.60.13]:41737 "EHLO
	imap.camline.com") by vger.kernel.org with ESMTP id S261943AbTKCJka
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Nov 2003 04:40:30 -0500
Date: Mon, 3 Nov 2003 10:40:21 +0100 (MET)
From: <matze@camline.com>
To: Andi Kleen <ak@suse.de>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM: Oops in __is_prefetch with 2.6.0-test9-bk4 at boot time
 with Athlon XP 1800+
In-Reply-To: <20031102143535.0b9b39f2.ak@suse.de>
Message-ID: <Pine.LNX.4.33.0311031032250.31704-100000@homer2.camline.com>
Organization: camLine Datensysteme fuer die Mikroelektronik
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2 Nov 2003, Andi Kleen wrote:

> Maybe you just have a miscompilation of some sort. Do a make mrproper and try
> again. You can also try if it happens with a smaller configuration.

I thought more about this... and looked into Documentation/Changes again
for the compiler version. All the reports at linux-kernel about timings
and kernel image size made me think, that gcc 3.x is no problem anymore.

And it seems that gcc 3.3.2 miscompiles something with my configuration. I
did a quick test using 2.95.3 today in the morning and the bootup seemed
to work.

I'm at work now, but I'll do some more tests tonight.

Sorry, that I've wasted your time, I should have known this.

If anybody is interested to track down the miscompilings, I can provide
any info needed. The least what I can do...

Thanks,
	Matze


-- 
Matthias Hanisch    mailto:matze@camline.com    phone: +49 8137 935-219

