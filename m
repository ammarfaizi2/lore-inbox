Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264482AbRFOStF>; Fri, 15 Jun 2001 14:49:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264484AbRFOSsz>; Fri, 15 Jun 2001 14:48:55 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:51729 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S264482AbRFOSsr>; Fri, 15 Jun 2001 14:48:47 -0400
Date: Fri, 15 Jun 2001 15:46:59 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: "Michael Nguyen" <mnguyen@ariodata.com>,
        "David S. Miller" <davem@redhat.com>,
        "Petko Manolov" <pmanolov@Lnxw.COM>, <linux-kernel@vger.kernel.org>
Subject: Re: RE2: kmalloc
Message-ID: <20010615154659.A942@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Anton Altaparmakov <aia21@cam.ac.uk>,
	"Michael Nguyen" <mnguyen@ariodata.com>,
	"David S. Miller" <davem@redhat.com>,
	"Petko Manolov" <pmanolov@Lnxw.COM>, <linux-kernel@vger.kernel.org>
In-Reply-To: <8A098FDFC6EED94B872CA2033711F86F01A9A2@orion.ariodata.com> <8A098FDFC6EED94B872CA2033711F86F01A9A2@orion.ariodata.com> <20010615145856.C960@conectiva.com.br> <5.1.0.14.2.20010615192508.00afe540@pop.cus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <5.1.0.14.2.20010615192508.00afe540@pop.cus.cam.ac.uk>; from aia21@cam.ac.uk on Fri, Jun 15, 2001 at 07:26:16PM +0100
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Jun 15, 2001 at 07:26:16PM +0100, Anton Altaparmakov escreveu:
> At 18:58 15/06/2001, Arnaldo Carvalho de Melo wrote:
> >Em Fri, Jun 15, 2001 at 10:41:59AM -0700, Michael Nguyen escreveu:
> > > >>Petko Manolov writes:
> > > >> kmalloc fails to allocate more than 128KB of
> > > >> memory regardless of the flags (GFP_KERNEL/USER/ATOMIC)
> > > >>
> > > >> Any ideas?
> > >
> > > >Yes, this is the limit.
> > >
> > > Im relatively new to Linux. I would like to ask.
> > > Is this limit per kmalloc()? Can I do this multiple times?
> >
> >the limit is for a single invocation of kmalloc, yes, you can do it multiple
> >times.
> 
> But if you need that much memory it would be better that you use vmalloc AFAIK.

Yup, like I suggested to Petko in a previous message :)

- Arnaldo
