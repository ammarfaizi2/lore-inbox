Return-Path: <linux-kernel-owner+w=401wt.eu-S1753652AbWLRJm6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753652AbWLRJm6 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 04:42:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753654AbWLRJm6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 04:42:58 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:58606 "EHLO
	rubicon.netdirect.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753652AbWLRJm6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 04:42:58 -0500
X-Originating-Ip: 24.148.236.183
Date: Mon, 18 Dec 2006 04:38:39 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] Make entries in the "Device drivers" menu individually
 selectable
In-Reply-To: <4583D008.40806@s5r6.in-berlin.de>
Message-ID: <Pine.LNX.4.64.0612180431160.16929@localhost.localdomain>
References: <Pine.LNX.4.64.0612140325340.13847@localhost.localdomain>
 <4583D008.40806@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-14.754, required 5, ALL_TRUSTED -1.80, BAYES_00 -15.00,
	RCVD_IN_SORBS_DUL 2.05)
X-Net-Direct-Inc-MailScanner-From: rpjday@mindspring.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Dec 2006, Stefan Richter wrote:

> Robert P. J. Day wrote on 2006-12-14:
> >   i've posted on this before so here's a slightly-updated patch
> > that uses the kbuild "menuconfig" feature to make numerous entries
> > under the Device drivers menu selectable on the spot.
>
> Works for me, but I don't see a lot of benefit from it. Actually I
> see two disadvantages of the patch:
>
>  - Without the patch, the choice of y/m/n for a subsystem and the
> help text is put aside into the submenu. I find this current layout
> simpler and quieter.

it's certainly "simpler and quieter" in one sense, but one need only
look at a submenu like "Network device support" to see a very "loud"
menu, so it's not like this patch would be introducing an
unprecedented level of noise.

also, in the Device Drivers menu, i find it slightly annoying that i
have to *enter* a submenu to read its help information.  if i see the
entry, say, "Dallas's 1-wire bus" and i have no idea what that is and
select "Help", i get the generic help screen.  i need to select that
entry and enter the submenu just to read its top-level help.

in any event, i'm sure folks understand what i'm after here.  if
there's a cleaner and more efficient way to do this, that would work
for me.

rday
