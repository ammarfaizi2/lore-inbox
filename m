Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265189AbRF0MGR>; Wed, 27 Jun 2001 08:06:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265311AbRF0MF5>; Wed, 27 Jun 2001 08:05:57 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:1296 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S265189AbRF0MF4>; Wed, 27 Jun 2001 08:05:56 -0400
Date: Wed, 27 Jun 2001 07:32:42 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Tim Waugh <twaugh@redhat.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: parport_pc tries to load parport_serial automatically
In-Reply-To: <20010626162102.F7663@redhat.com>
Message-ID: <Pine.LNX.4.21.0106270732160.1331-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 26 Jun 2001, Tim Waugh wrote:

> On Tue, Jun 26, 2001 at 10:30:41AM -0300, Marcelo Tosatti wrote:
> 
> > > - change parport_pc so that it doesn't request parport_serial at
> > >   init.  In this case, how will parport_serial get loaded at all?
> > >   Perhaps with some recommended /etc/modules.conf lines (perhaps
> > >   parport_lowlevel{1,2,3,...})?
> > 
> > I think this is sane. This is how it works for parport_pc.
> 
> Right.  Actually, setting an alias of parport_lowlevel to
> parport_serial would cause the right things to happen I think.

So, 

Could you remove the request_module() from parport_pc ? 

Thanks Tim 

