Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161073AbWGUMkP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161073AbWGUMkP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jul 2006 08:40:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161071AbWGUMkO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jul 2006 08:40:14 -0400
Received: from outmx020.isp.belgacom.be ([195.238.4.201]:5605 "EHLO
	outmx020.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S1161069AbWGUMkM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jul 2006 08:40:12 -0400
Subject: Re: [PATCH] drivers: Conversions from kmalloc+memset to
	k(z|c)alloc.
From: Panagiotis Issaris <takis@gna.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Panagiotis Issaris <takis@lumumba.uhasselt.be>,
       linux-kernel@vger.kernel.org, len.brown@intel.com,
       chas@cmf.nrl.navy.mil, miquel@df.uba.ar, kkeil@suse.de,
       benh@kernel.crashing.org, video4linux-list@redhat.com,
       rmk+mmc@arm.linux.org.uk, Neela.Kolli@engenio.com, jgarzik@pobox.com,
       vandrove@vc.cvut.cz, adaplas@pol.net, thomas@winischhofer.net,
       weissg@vienna.at, philb@gnu.org, linux-pcmcia@lists.infradead.org,
       jkmaline@cc.hut.fi, paulus@samba.org
In-Reply-To: <d120d5000607210535u6e8cad16u895cbb4671119dbc@mail.gmail.com>
References: <20060720190529.GC7643@lumumba.uhasselt.be>
	 <d120d5000607210535u6e8cad16u895cbb4671119dbc@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 21 Jul 2006 14:39:58 +0200
Message-Id: <1153485598.9489.39.camel@hemera>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On vr, 2006-07-21 at 08:35 -0400, Dmitry Torokhov wrote:
> On 7/20/06, Panagiotis Issaris <takis@lumumba.uhasselt.be> wrote:
> > From: Panagiotis Issaris <takis@issaris.org>
> >
> > drivers: Conversions from kmalloc+memset to k(z|c)alloc.
> >
> > Signed-off-by: Panagiotis Issaris <takis@issaris.org>
> > ---
> > Second edition
> >
> >  drivers/acpi/hotkey.c                      |    6 ++----
> >  drivers/atm/zatm.c                         |    6 ++----
> >  drivers/char/consolemap.c                  |    6 ++----
> >  drivers/char/keyboard.c                    |    4 ++--
> 
> Hi,
> 
> Could you please drop drivers/char/keyboard.c changes? I already have
> patch in my queue that does kzalloc conversion there (among other
> things).
> 
> Thanks!
Ofcourse! Consider it done! :)

With friendly regards,
Takis

