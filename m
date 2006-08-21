Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030424AbWHUMwc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030424AbWHUMwc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 08:52:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030433AbWHUMwb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 08:52:31 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:19871 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030424AbWHUMwH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 08:52:07 -0400
Subject: Re: Polling for battery stauts and lost keypresses
From: Arjan van de Ven <arjan@infradead.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Giuseppe Bilotta <bilotta78@hotpop.com>, linux-kernel@vger.kernel.org
In-Reply-To: <d120d5000608210534h28bda198l116ac2ce94c484ed@mail.gmail.com>
References: <BAY114-F2C4913B499BE3113C8E9BFA4E0@phx.gbl>
	 <d120d5000608141317p50540cd5x5e8ec409dc9343ef@mail.gmail.com>
	 <gd60xm38im9j.a4xxz8tjb0qj$.dlg@40tude.net>
	 <200608191150.47183.dtor@insightbb.com>
	 <1156003338.2875.85.camel@laptopd505.fenrus.org>
	 <d120d5000608210534h28bda198l116ac2ce94c484ed@mail.gmail.com>
Content-Type: text/plain
Organization: Intel International BV
Date: Mon, 21 Aug 2006 14:52:03 +0200
Message-Id: <1156164723.23756.167.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-08-21 at 08:34 -0400, Dmitry Torokhov wrote:
> On 8/19/06, Arjan van de Ven <arjan@infradead.org> wrote:
> > On Sat, 2006-08-19 at 11:50 -0400, Dmitry Torokhov wrote:
> > > On Wednesday 16 August 2006 03:31, Giuseppe Bilotta wrote:
> > > > On Mon, 14 Aug 2006 16:17:01 -0400, Dmitry Torokhov wrote:
> > > >
> > > > > 2. Quite often there are OEM drivers that are tweaked to a specific
> > > > > hardware and involve hardware-specific hacks.
> > > >
> > > > If I remember correctly (damn, I can't find a way to do a search on
> > > > the LKML archives ...) there was someone working on Dell stuff, at
> > > > least as far as fans and thermal sensors were concerned (based on the
> > > > code from Massimo Dal Zotto) to integrate them with the kernel sensors
> > > > framework. However, some of those patches where NACKed by someone from
> > > > Dell because they were sort of "guessy" about the addresses to poke
> > > > around to get the information, instead of using the data provided by
> > > > the BIOS on where to look for them ... however, there hasn't been any
> > > > news about that that stuff since ...
> > > >
> > >
> > > As far as I remember that person from Dell was not ready to disclose
> > > details of their SMBIOS :( so it naturally went nowhere.
> >
> > actually Dell did document their smbios ...
> >
> > http://linux.dell.com/libsmbios/main/index.html
> >
> > there was also a posting from Dell with details, but I assume that's
> > included in their libsmbios...
> >
> 
> I could not find any fan control or temperature monitoring references
> there. Maybe I missed them.
there was an lkml posting from a Dell guy with a full table, just that
my google skills seem to be not successful at locating it right now.


