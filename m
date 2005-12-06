Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964904AbVLFBjj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964904AbVLFBjj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 20:39:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964905AbVLFBjj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 20:39:39 -0500
Received: from b3162.static.pacific.net.au ([203.143.238.98]:50643 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S964904AbVLFBji (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 20:39:38 -0500
Subject: Re: swsusp performance problems in 2.6.15-rc3-mm1
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Pavel Machek <pavel@ucw.cz>, Andy Isaacson <adi@hexapodia.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200512052328.01999.rjw@sisk.pl>
References: <20051205081935.GI22168@hexapodia.org>
	 <20051205121728.GF5509@elf.ucw.cz>
	 <1133791084.3872.53.camel@laptop.cunninghams>
	 <200512052328.01999.rjw@sisk.pl>
Content-Type: text/plain
Organization: Cyclades
Message-Id: <1133832773.6360.38.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Tue, 06 Dec 2005 11:36:13 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi again.

On Tue, 2005-12-06 at 08:28, Rafael J. Wysocki wrote:
> Hi,
> 
> On Monday, 5 December 2005 14:58, Nigel Cunningham wrote:
> > On Mon, 2005-12-05 at 22:17, Pavel Machek wrote:
> > > > On recent kernels such as 2.6.14-rc2-mm1, a swsusp of my laptop (1.25
> > > > GB, P4M 1.4 GHz) was a pretty fast process; freeing memory took about 3
> > > > seconds or less, and writing out the swap image took less than 5
> > > > seconds, so within 15 seconds of running my suspend script power was
> > > > off.
> > > 
> > > So suspend took 15 second, and boot another 5 to read the image + 20
> > > first time desktops are switched. ... ~40 second total.
> > 
> > Plus what is mentioned in the next paragraph.
> 
> Indeed.  Yet, the point has been made and backed up with some numbers:
> There's at least one swsusp user (Andy) who would apparently _prefer_ if more
> memory were freed during suspend.  The reason is the amount of
> RAM in the Andy's box.

Perhaps I wasn't clear enough. I was arguing that if you get your prompt
back in 40s, but the computer is still thrashing for the next minute or
ten, you haven't really finished resuming yet.

Regards,

Nigel

