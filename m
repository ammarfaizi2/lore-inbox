Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261664AbSLHViK>; Sun, 8 Dec 2002 16:38:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261693AbSLHViK>; Sun, 8 Dec 2002 16:38:10 -0500
Received: from [195.39.17.254] ([195.39.17.254]:7940 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S261664AbSLHViJ>;
	Sun, 8 Dec 2002 16:38:09 -0500
Date: Fri, 6 Dec 2002 09:17:21 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Shawn Starr <shawn.starr@datawire.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.5.50, ACPI] link error
Message-ID: <20021206081721.GA1865@zaurus>
References: <200212041605.11935.shawn.starr@datawire.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200212041605.11935.shawn.starr@datawire.net>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Thats what I thought until Pavel told me SOFTWARE_SUSPEND requires ACPI_SLEEP 
> and ACPI_SLEEP should not be unchecked if SOFTWARE_SUSPEND is disabled.

Did I say that? That is wrong, sorry. acpi_sleep 
should require swsusp but not the other way
round.
-- 
				Pavel
Written on sharp zaurus, because my Velo1 broke. If you have Velo you don't need...

