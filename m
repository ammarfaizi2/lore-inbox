Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317025AbSFASYo>; Sat, 1 Jun 2002 14:24:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317026AbSFASYn>; Sat, 1 Jun 2002 14:24:43 -0400
Received: from ool-182d14cd.dyn.optonline.net ([24.45.20.205]:12 "HELO
	osinvestor.com") by vger.kernel.org with SMTP id <S317025AbSFASYn>;
	Sat, 1 Jun 2002 14:24:43 -0400
Date: Sat, 1 Jun 2002 14:24:41 -0400
From: Rob Radez <rob@osinvestor.com>
To: Joel Becker <Joel.Becker@oracle.com>
Cc: linux-kernel@vger.kernel.org, Rob Radez <rob@osinvestor.com>,
        Matt Domsch <Matt_Domsch@dell.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Watchdog Stuff (1/4)
Message-ID: <20020601142441.T30977@osinvestor.com>
In-Reply-To: <20020601064309.GA10222@insight.us.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 31, 2002 at 11:43:36PM -0700, Joel Becker wrote:
> 	Here are four patches for the watchdog drivers.  These patches
> are against 2.4.19-pre9.
> 	The first patch (this one) adds WDIOC_SETTIMEOUT support to
> wafer5823wdt.c.  The second patch adds Matt Domsch's 'nowayout' module
> option to the drivers that currently don't have it.  The third patch
> fixes a bug where most of the "magic close character" capable drivers
> don't use get_user().  The fourth patch adds "magic close character"
> support to almost all of the remaining drivers.  It also adds
> WDIOF_MAGICCLOSE to the driver info flags.

The changes (patch 1) to wafer5823wdt.c are already in my tree.  Patches 3 and
4 have just been pretty much applied (except for stuff that depends on patch
2), and patch 2 is in the process of being applied.  Of course, this isn't
any kind of official statement, just a progress report :-).

Regards,
Rob Radez
