Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269423AbRHCPqK>; Fri, 3 Aug 2001 11:46:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269421AbRHCPpv>; Fri, 3 Aug 2001 11:45:51 -0400
Received: from linux06.unm.edu ([129.24.15.38]:12814 "HELO linux06.unm.edu")
	by vger.kernel.org with SMTP id <S269420AbRHCPps>;
	Fri, 3 Aug 2001 11:45:48 -0400
Date: Fri, 3 Aug 2001 09:45:56 -0600 (MDT)
From: Todd <todd@unm.edu>
To: "chen, xiangping" <chen_xiangping@emc.com>
cc: <linux-kernel@vger.kernel.org>
Subject: RE: PCI bus speed
In-Reply-To: <276737EB1EC5D311AB950090273BEFDD043BC53A@elway.lss.emc.com>
Message-ID: <Pine.A41.4.33.0108030945140.19654-100000@aix05.unm.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

chen,

i think that if you look at the speed of the bridge, that is the speed the
bridge wants to run the bus at.  as another poster noted, this doesn't
really tell you the speed the bus is actually clocked at.

t.

On Fri, 3 Aug 2001, chen, xiangping wrote:

> Date: Fri, 3 Aug 2001 10:27:10 -0400
> From: "chen, xiangping" <chen_xiangping@emc.com>
> To: 'Todd' <todd@unm.edu>
> Cc: linux-kernel@vger.kernel.org
> Subject: RE: PCI bus speed
>
> yes. I see some items with flags listed as:
> 	Flags: bus master, 66Mhz, medium devsel, latency 64, IRQ 10
>
> Is it suppose to mean that the bus freq is 66Mhz?
>
> Thanks,
>
> Xiangping
>
> -----Original Message-----
> From: Todd [mailto:todd@unm.edu]
> Sent: Thursday, August 02, 2001 8:03 PM
> To: chen, xiangping
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: PCI bus speed
>
>
> xiangping,
>
> try
>
> lspci -v
>
> the info you want is there.
>
> todd
>
> On Thu, 2 Aug 2001, chen, xiangping wrote:
>
> > Date: Thu, 2 Aug 2001 18:47:49 -0400
> > From: "chen, xiangping" <chen_xiangping@emc.com>
> > To: linux-kernel@vger.kernel.org
> > Subject: PCI bus speed
> >
> > Hi,
> >
> > Is there any easy way to probe the PCI bus speed
> > of an Intel box?
> >
> > Thanks,
> >
> > Xiangping
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> >
>
> =========================================================
> Todd Underwood, todd@unm.edu
>
> =========================================================
>

=========================================================
Todd Underwood, todd@unm.edu

=========================================================

