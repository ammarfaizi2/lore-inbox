Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264819AbUFTAta@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264819AbUFTAta (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jun 2004 20:49:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264820AbUFTAta
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jun 2004 20:49:30 -0400
Received: from imap.gmx.net ([213.165.64.20]:29082 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S264819AbUFTAt2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jun 2004 20:49:28 -0400
X-Authenticated: #8834078
From: Dominik Karall <dominik.karall@gmx.net>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Subject: Re: linux-2.6.7-bk2 runs faster than linux-2.6.7 ;)
Date: Sun, 20 Jun 2004 02:58:52 +0200
User-Agent: KMail/1.6.2
Cc: Andrew Morton <akpm@osdl.org>, florin@iucha.net,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Len Brown <len.brown@intel.com>
References: <20040619210714.GD3243@iucha.net> <200406200237.54067.dominik.karall@gmx.net> <Pine.LNX.4.58.0406192029380.2228@montezuma.fsmlabs.com>
In-Reply-To: <Pine.LNX.4.58.0406192029380.2228@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200406200258.55793.dominik.karall@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 20 June 2004 02:30, Zwane Mwaikambo wrote:
> On Sun, 20 Jun 2004, Dominik Karall wrote:
> > On Sunday 20 June 2004 01:23, Andrew Morton wrote:
> > > Dominik Karall <dominik.karall@gmx.net> wrote:
> > > > > dmesg and .config, please.
> > > >
> > > >  attached
> > >
> > > The dmesg output is incomplete.  You'll need to use `dmesg -s 1000000'
> > > to get all of it.
> > >
> > > I wish that would get fixed actually.  Seems a bit silly, and current
> > > kernels permit querying of the ringbuffer size.
> >
> > 'dmesg -s 1000000' output attached.
>
> Try booting with 'acpi=off'
>
> IRQ to pin mappings:
> IRQ0 -> 0:0-> 0:2

After booting with 'acpi=off' it works as normal.

dmesg
...
IRQ to pin mappings:
IRQ0 -> 0:2
....

Let me know if you need more information.

greets dominik
