Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264083AbRFNVko>; Thu, 14 Jun 2001 17:40:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264086AbRFNVkh>; Thu, 14 Jun 2001 17:40:37 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:65293 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S264083AbRFNVkT>; Thu, 14 Jun 2001 17:40:19 -0400
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: Linux-2.4.6-pre3
Date: 14 Jun 2001 14:39:40 -0700
Organization: A poorly-installed InterNetNews site
Message-ID: <9gbaus$564$1@penguin.transmeta.com>
In-Reply-To: <26832.992400011@ocs4.ocs-net> <E15AbRo-00053O-00@the-village.bc.nu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <E15AbRo-00053O-00@the-village.bc.nu>,
Alan Cox  <alan@lxorguk.ukuu.org.uk> wrote:
>
>Use pre2. Linus applied a patch that changed the PCI power management stuff
>and broke all the drivers.

It shouldn't have broken anything.  The warning happens, but the
function call ends up doing the same thing as it used to - old drivers
will just ignore the new argument. 

It was a necessary step in working ACPI suspend.  Which Patrick has
working - with caveats.  And the fact that Pat happens to work at the
same company I do probably has more to do with the fact that Transmeta
is obviously interested in suspend issues more than most - and not so
much with the fact that he would exert undue influence on me. 

		Linus
