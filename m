Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267135AbSLDX3e>; Wed, 4 Dec 2002 18:29:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267139AbSLDX3e>; Wed, 4 Dec 2002 18:29:34 -0500
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:7947 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id <S267135AbSLDX3e>; Wed, 4 Dec 2002 18:29:34 -0500
Date: Thu, 5 Dec 2002 00:37:00 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Shawn Starr <shawnstarr@mobile.rogers.com>
cc: shawn.starr@datawire.net, <linux-kernel@vger.kernel.org>
Subject: Re: [2.5.50, ACPI] link error
In-Reply-To: <200212042312.gB4NC8UJ021406@BlackBerry.NET>
Message-ID: <Pine.LNX.4.44.0212050030190.2113-100000@serv>
References: <200212042312.gB4NC8UJ021406@BlackBerry.NET>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 4 Dec 2002, Shawn Starr wrote:

> Well, SOFTWARE_SUSPEND needs ACPI_SLEEP. If ACPI_SLEEP is selected only then we don't care about software suspend. 
> 
> So to list:
> 
> 1). SOFTWARE_SUSPEND requires ACPI_SLEEP.
> 2). ACPI_SLEEP does not require SOFTWARE_SUSPEND.
> 
> That's about it =)

That doesn't make it really easier. I want a table like this:

SUSPEND	SLEEP	SUSPEND visible? SLEEP visible?
n	n
n	y	
y	y

All I can parse from above is that SUSPEND=y && SLEEP=n isn't possible, 
but what are the possible user choices and how does the state change if 
the user (de)selects an option?

bye, Roman

