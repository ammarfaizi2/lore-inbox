Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030228AbVIIQ4E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030228AbVIIQ4E (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 12:56:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030233AbVIIQ4E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 12:56:04 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:21699 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1030228AbVIIQ4D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 12:56:03 -0400
Date: Fri, 9 Sep 2005 18:55:52 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: viro@ZenIV.linux.org.uk
cc: Eric Piel <Eric.Piel@lifl.fr>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bogus #if (acpi/blacklist)
In-Reply-To: <20050909164358.GP9623@ZenIV.linux.org.uk>
Message-ID: <Pine.LNX.4.61.0509091854500.3743@scrub.home>
References: <20050909160723.GI9623@ZenIV.linux.org.uk> <4321B5F6.4040707@lifl.fr>
 <20050909164358.GP9623@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 9 Sep 2005 viro@ZenIV.linux.org.uk wrote:

> Sigh...  It should be left as #if, of course, but I suspect that cleaner way to
> deal with that would be (in Kconfig)
> 
> config ACPI_BLACKLIST_YEAR
>         int "Disable ACPI for systems before Jan 1st this year" if X86
>         default 0

That would be indeed the better fix.

bye, Roman
