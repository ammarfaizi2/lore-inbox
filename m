Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262308AbTLSKjp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Dec 2003 05:39:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262352AbTLSKjp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Dec 2003 05:39:45 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:33030 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S262308AbTLSKjn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Dec 2003 05:39:43 -0500
Message-ID: <3FE2D80E.4070107@aitel.hist.no>
Date: Fri, 19 Dec 2003 11:50:54 +0100
From: Helge Hafting <helgehaf@aitel.hist.no>
Organization: AITeL, HiST
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107 Debian/1.5-3
X-Accept-Language: no, en
MIME-Version: 1.0
To: Michael Hunold <hunold@convergence.de>
CC: Steffen Schwientek <schwientek@web.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.6-test11 framebuffer Matrox
References: <200312190314.13138.schwientek@web.de> <3FE2B717.7020502@convergence.de>
In-Reply-To: <3FE2B717.7020502@convergence.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Hunold wrote:
> Hello Steffen,
> 
>> My Matrox-framebuffer is not working properly. Build direct into the
>> kernel, the monitor will be black with some stripes at startup, just the
>> reset button works.
>> Build as a modules, the same happens if I load the module.
> 
> 
> All I can say is "me, too". 8-(
> 
>> Steffen
> 
> 
> Can somebody definately say if "matroxfb" is working for 2.6? I haven't 
> tested it for a while, but I was surprised to find it non-working in 2.6...

The matrox framebuffer works with 2.6.0-test11 and a matrox G550.
This is statically compiled, with smp and preempt.

It dies if I use fbcon + the ruby patch (for multiple keyboard support) though.
So something is wrong - this patch changes the console but not the fb driver
so it isn't supposed to crash.  I guess there's some problem with the driver
that gets triggered only in some circumstances.

Helge Hafting

