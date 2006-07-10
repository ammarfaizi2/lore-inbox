Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965291AbWGJWh3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965291AbWGJWh3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 18:37:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965294AbWGJWh3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 18:37:29 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:1938 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S965291AbWGJWh2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 18:37:28 -0400
Date: Tue, 11 Jul 2006 00:37:06 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Pavel Machek <pavel@ucw.cz>
cc: john stultz <johnstul@us.ibm.com>, Mikael Pettersson <mikpe@it.uu.se>,
       linux-kernel@vger.kernel.org
Subject: Re: [BUG] APM resume breakage from 2.6.18-rc1 clocksource changes
In-Reply-To: <20060710180839.GA16503@elf.ucw.cz>
Message-ID: <Pine.LNX.4.64.0607110035300.17704@scrub.home>
References: <200607092352.k69NqZuJ029196@harpo.it.uu.se>
 <1152554328.5320.6.camel@localhost.localdomain> <20060710180839.GA16503@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 10 Jul 2006, Pavel Machek wrote:

> APM can only keep interrupts disabled on non-IBM machines, presumably
> due to BIOS problems.

Is it possible to disable the timer interrupt before suspend and just 
reinit the timer afterwards?

bye, Roman
