Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932123AbVIUGVr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932123AbVIUGVr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 02:21:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932127AbVIUGVr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 02:21:47 -0400
Received: from smtp.osdl.org ([65.172.181.4]:58310 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932123AbVIUGVr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 02:21:47 -0400
Date: Tue, 20 Sep 2005 23:21:02 -0700
From: Andrew Morton <akpm@osdl.org>
To: Marc Perkel <marc@perkel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Lost Ticks - TSC Timer - AMD 64 X2 Processor - What's up with
 that?
Message-Id: <20050920232102.4cf1cedf.akpm@osdl.org>
In-Reply-To: <43302616.6000908@perkel.com>
References: <43302616.6000908@perkel.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marc Perkel <marc@perkel.com> wrote:
>
> Having timer problems. About to head to the data center to try different 
> things to get this server to work right. Losing ticks and clock is all 
> over the place and doing obscene things to keep it almost on track - but 
> I really need a solution.
> 
> Running 2.6.13.1 Kernel - FC4 Linux - Asus Motherboard - A8N-SLI 
> Premium. Athlon X2 4400+ with 4 gigs of ram and it uses some sort of 
> memory remapping to use the full 4 gigs.
> 
> I don't understand all the different timers. There's TSC and PM and what 
> else?
> 
> Someone suggested "notsc" which I will try when I get there. But  - 
> looking for a list of other things to try as well. I have flashed the 
> latest BIOS.
> 
> I'm thinking about giving up and going back to DOS. I didn't have these 
> problem with DOS - and DOS boots faster. ;)
> 
> Tell me about all these timers - what are my choices - and what is most 
> likely to actually work.
> 

Grab a coffee, go read http://bugzilla.kernel.org/show_bug.cgi?id=5105

Using "clock=pit" might help.
