Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262156AbTJXX7U (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Oct 2003 19:59:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262168AbTJXX7U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Oct 2003 19:59:20 -0400
Received: from smtp1.clear.net.nz ([203.97.33.27]:7383 "EHLO
	smtp1.clear.net.nz") by vger.kernel.org with ESMTP id S262156AbTJXX7T
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Oct 2003 19:59:19 -0400
Date: Sat, 25 Oct 2003 12:59:57 +1300
From: Nigel Cunningham <ncunningham@clear.net.nz>
Subject: Re: [PM][ACPI] No ACPI interrupts after resume from S1
In-reply-to: <yw1xbrs6p85n.fsf@kth.se>
To: =?ISO-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@kth.se>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ACPI List <acpi-devel@lists.sourceforge.net>
Message-id: <1067039997.2114.16.camel@laptop-linux>
Organization: 
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.2.2
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 8BIT
References: <20031020141512.GA30157@hell.org.pl>
 <yw1x8yngj7xg.fsf@users.sourceforge.net> <20031020184750.GA26154@hell.org.pl>
 <yw1xekx7afrz.fsf@kth.se> <20031023082534.GD643@openzaurus.ucw.cz>
 <yw1xr813f1a3.fsf@kth.se> <3F98FDDF.1040905@cyberone.com.au>
 <yw1xbrs6652m.fsf@kth.se> <20031024222347.GB728@elf.ucw.cz>
 <yw1xbrs6p85n.fsf@kth.se>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some modules cause problems. If I suspend with the intel-agp driver
loaded, for example, the computer reboots when copying the original
kernel back, because the hardware state doesn't match. I can suspend and
resume my i830 based laptop just fine without it. Once the right changes
are made to the driver, the module will work, but not yet.

Pavel, excuse me for jumping in here.

Regards,

Nigel

On Sat, 2003-10-25 at 11:45, Måns Rullgård wrote:
> Pavel Machek <pavel@ucw.cz> writes:
> 
> > Try it completely without modules. I'm not sure how it should work
> > with modules which means it probably does not work at all.
> 
> Are you saying it doesn't work with any modules?  What about all the
> people who have reported success with suspend-to-disk?  I thought
> everyone used at least some modules.
-- 
Nigel Cunningham
495 St Georges Road South, Hastings 4201, New Zealand

Evolution (n): A hypothetical process whereby infinitely improbable events occur 
with alarming frequency, order arises from chaos, and no one is given credit.

