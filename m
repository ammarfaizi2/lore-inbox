Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265984AbSKBTEx>; Sat, 2 Nov 2002 14:04:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265985AbSKBTEx>; Sat, 2 Nov 2002 14:04:53 -0500
Received: from amsfep11-int.chello.nl ([213.46.243.20]:2861 "EHLO
	amsfep11-int.chello.nl") by vger.kernel.org with ESMTP
	id <S265984AbSKBTEw>; Sat, 2 Nov 2002 14:04:52 -0500
Content-Type: text/plain; charset=US-ASCII
From: Jos Hulzink <josh@stack.nl>
To: Dave Jones <davej@codemonkey.org.uk>
Subject: Re: 2.5.45 build failed with ACPI turned on
Date: Sat, 2 Nov 2002 21:11:25 +0100
User-Agent: KMail/1.4.3
Cc: "Grover, Andrew" <andrew.grover@intel.com>,
       Robert Varga <nite@hq.alert.sk>, linux-kernel@vger.kernel.org
References: <EDC461A30AC4D511ADE10002A5072CAD04C7A498@orsmsx119.jf.intel.com> <200211012221.56346.josh@stack.nl> <20021101203121.GB2329@suse.de>
In-Reply-To: <20021101203121.GB2329@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200211022111.25198.josh@stack.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 01 November 2002 21:31, Dave Jones wrote:
> On Fri, Nov 01, 2002 at 10:21:56PM +0100, Jos Hulzink wrote:
>  > Other issue: Are ACPI and APM not mutually exclusive ? If so, I would
>  > propose a selection box: <ACPI> <APM> <none> with related options shown
>  > below. Hmzz.. there the issue of the fact that ACPI is more than power
>  > management shows up again.
>
> Whilst they can't both run at the same time, it's perfectly possible
> (and useful) to build a kernel with both included. ACPI will quit
> if APM is already running, so booting with apm=off turns the same
> kernel into 'ACPI mode'

Hmzz.. in that case I vote for dropping CONFIG_PM in favour of CONFIG_APM || CONFIG_ACPI, even though it requires some more typing for the programmers. (I'm no ACPI programmer, so I don't care ;-)

Jos

