Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264436AbRFOSBN>; Fri, 15 Jun 2001 14:01:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264460AbRFOSBD>; Fri, 15 Jun 2001 14:01:03 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:61707 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S264436AbRFOSA5>; Fri, 15 Jun 2001 14:00:57 -0400
Date: Fri, 15 Jun 2001 14:58:56 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: "Michael Nguyen" <mnguyen@ariodata.com>
Cc: "David S. Miller" <davem@redhat.com>, "Petko Manolov" <pmanolov@Lnxw.COM>,
        <linux-kernel@vger.kernel.org>
Subject: Re: RE2: kmalloc
Message-ID: <20010615145856.C960@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	"Michael Nguyen" <mnguyen@ariodata.com>,
	"David S. Miller" <davem@redhat.com>,
	"Petko Manolov" <pmanolov@Lnxw.COM>, <linux-kernel@vger.kernel.org>
In-Reply-To: <8A098FDFC6EED94B872CA2033711F86F01A9A2@orion.ariodata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <8A098FDFC6EED94B872CA2033711F86F01A9A2@orion.ariodata.com>; from mnguyen@ariodata.com on Fri, Jun 15, 2001 at 10:41:59AM -0700
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Jun 15, 2001 at 10:41:59AM -0700, Michael Nguyen escreveu:
> Hi David,
> 
> >>Petko Manolov writes:
> >> kmalloc fails to allocate more than 128KB of
> >> memory regardless of the flags (GFP_KERNEL/USER/ATOMIC)
> >> 
> >> Any ideas?
> 
> >Yes, this is the limit.
> 
> Im relatively new to Linux. I would like to ask.
> Is this limit per kmalloc()? Can I do this multiple times?

the limit is for a single invocation of kmalloc, yes, you can do it multiple
times.

- Arnaldo
