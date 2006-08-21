Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751850AbWHUMeh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751850AbWHUMeh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 08:34:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751136AbWHUMeg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 08:34:36 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:31297 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751850AbWHUMef (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 08:34:35 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=UOWtULhyE0b01MP2PAwO29C9PmycYcpxIRABVtNzzGTTHL7uQ5wJ8L73R3kqAN2SEeHDGiSHFx4cQ/bKeFpT0VoFAYKM8P3uaSYgaFODBk+uUM2IwyHmnq6a4Zs8G8+51JkM7nUAqLjerlgLrRepStVbxNz7V2FLUlUxG8tQM7w=
Message-ID: <d120d5000608210534h28bda198l116ac2ce94c484ed@mail.gmail.com>
Date: Mon, 21 Aug 2006 08:34:34 -0400
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
To: "Arjan van de Ven" <arjan@infradead.org>
Subject: Re: Polling for battery stauts and lost keypresses
Cc: "Giuseppe Bilotta" <bilotta78@hotpop.com>, linux-kernel@vger.kernel.org
In-Reply-To: <1156003338.2875.85.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <BAY114-F2C4913B499BE3113C8E9BFA4E0@phx.gbl>
	 <d120d5000608141317p50540cd5x5e8ec409dc9343ef@mail.gmail.com>
	 <gd60xm38im9j.a4xxz8tjb0qj$.dlg@40tude.net>
	 <200608191150.47183.dtor@insightbb.com>
	 <1156003338.2875.85.camel@laptopd505.fenrus.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/19/06, Arjan van de Ven <arjan@infradead.org> wrote:
> On Sat, 2006-08-19 at 11:50 -0400, Dmitry Torokhov wrote:
> > On Wednesday 16 August 2006 03:31, Giuseppe Bilotta wrote:
> > > On Mon, 14 Aug 2006 16:17:01 -0400, Dmitry Torokhov wrote:
> > >
> > > > 2. Quite often there are OEM drivers that are tweaked to a specific
> > > > hardware and involve hardware-specific hacks.
> > >
> > > If I remember correctly (damn, I can't find a way to do a search on
> > > the LKML archives ...) there was someone working on Dell stuff, at
> > > least as far as fans and thermal sensors were concerned (based on the
> > > code from Massimo Dal Zotto) to integrate them with the kernel sensors
> > > framework. However, some of those patches where NACKed by someone from
> > > Dell because they were sort of "guessy" about the addresses to poke
> > > around to get the information, instead of using the data provided by
> > > the BIOS on where to look for them ... however, there hasn't been any
> > > news about that that stuff since ...
> > >
> >
> > As far as I remember that person from Dell was not ready to disclose
> > details of their SMBIOS :( so it naturally went nowhere.
>
> actually Dell did document their smbios ...
>
> http://linux.dell.com/libsmbios/main/index.html
>
> there was also a posting from Dell with details, but I assume that's
> included in their libsmbios...
>

I could not find any fan control or temperature monitoring references
there. Maybe I missed them.

-- 
Dmitry
