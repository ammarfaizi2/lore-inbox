Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261590AbVALXaj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261590AbVALXaj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 18:30:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261560AbVALXaG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 18:30:06 -0500
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:29322 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S261570AbVALX0m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 18:26:42 -0500
Subject: Re: 2.6.10-mm2: swsusp regression [update]
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Pavel Machek <pavel@suse.cz>, Andi Kleen <ak@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200501130002.37311.rjw@sisk.pl>
References: <20050106002240.00ac4611.akpm@osdl.org>
	 <200501122344.20589.rjw@sisk.pl> <20050112224641.GP1408@elf.ucw.cz>
	 <200501130002.37311.rjw@sisk.pl>
Content-Type: text/plain
Message-Id: <1105572485.2941.1.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Thu, 13 Jan 2005 10:28:05 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Thu, 2005-01-13 at 10:02, Rafael J. Wysocki wrote:
> Still, it's sleep_start that has a wrong value, apparently (it shouldn't be 
> negative, at least), and I see that Nigel has a patch that changes 
> __get_cmos_time() on x86_64.  I'm going to try it in a couple of minutes.

I sent a group of four patches, I think on Saturday. The first one is
the one Pavel wrongly attributed to me. The other three are mine. I
think you might need all four to get it working right.

Nigel
-- 
Nigel Cunningham
Software Engineer, Canberra, Australia
http://www.cyclades.com

Ph: +61 (2) 6292 8028      Mob: +61 (417) 100 574

