Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287310AbSACOmY>; Thu, 3 Jan 2002 09:42:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287307AbSACOmO>; Thu, 3 Jan 2002 09:42:14 -0500
Received: from ns.suse.de ([213.95.15.193]:12549 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S287306AbSACOmK>;
	Thu, 3 Jan 2002 09:42:10 -0500
Date: Thu, 3 Jan 2002 15:42:09 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: Kai Henningsen <kaih@khms.westfalen.de>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: ISA slot detection on PCI systems?
In-Reply-To: <8GBXFw6mw-B@khms.westfalen.de>
Message-ID: <Pine.LNX.4.33.0201031540390.7309-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3 Jan 2002, Kai Henningsen wrote:

> Now, if we cannot reliably autodetect hardware, we should always make it
> possible to override this manually, and maybe also inform the user that
> we're not certain. But that's no excuse not to try to autodetect when the
> user has *not* overridden us.

Autodetecting non-pnp ISA hardware safely is something of a black art.
Numerous drivers just hang if you load them and the card isn't present,
or there's another card which answers on the same port/address.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

