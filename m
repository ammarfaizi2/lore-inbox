Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267125AbSLDWcx>; Wed, 4 Dec 2002 17:32:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267130AbSLDWcx>; Wed, 4 Dec 2002 17:32:53 -0500
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:774 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id <S267125AbSLDWcw>; Wed, 4 Dec 2002 17:32:52 -0500
Date: Wed, 4 Dec 2002 23:40:17 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Shawn Starr <shawn.starr@datawire.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: [2.5.50, ACPI] link error
In-Reply-To: <200212041720.14647.shawn.starr@datawire.net>
Message-ID: <Pine.LNX.4.44.0212042333560.2113-100000@serv>
References: <200212041605.11935.shawn.starr@datawire.net>
 <Pine.LNX.4.44.0212042239590.2113-100000@serv> <200212041653.04475.shawn.starr@datawire.net>
 <200212041720.14647.shawn.starr@datawire.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 4 Dec 2002, Shawn Starr wrote:

> if ACPI_SLEEP = selected then display SOFTWARE_SUSPEND 
> else if SOFTWARE_SUSPEND selected select ACPI_SLEEP
> else if ACPI_SLEEP unselected unselect SOFTWARE_SUSPEND
> endif

Recursive dependencies are not allowed, the parser currently accepts them 
silently, but that will change.
Anyway, I don't really understand above, SOFTWARE_SUSPEND can only be 
selected if ACPI_SLEEP sleep is selected, so why should it select 
ACPI_SLEEP? 
Could you please make a table of all possible combinations?

bye, Roman

