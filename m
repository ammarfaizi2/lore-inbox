Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292730AbSC3WC6>; Sat, 30 Mar 2002 17:02:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292813AbSC3WCr>; Sat, 30 Mar 2002 17:02:47 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:35592
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S292730AbSC3WCd>; Sat, 30 Mar 2002 17:02:33 -0500
Date: Sat, 30 Mar 2002 14:01:14 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Art Wagner <awagner@westek-systems.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Jean-Luc Coulon <jean-luc.coulon@wanadoo.fr>,
        linux-kernel@vger.kernel.org
Subject: Re: 2.4.19-pre4-ac[23] do not boot
In-Reply-To: <3CA51A31.80405@westek-systems.com>
Message-ID: <Pine.LNX.4.10.10203301400540.10681-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Fixed now!
Code drop tonight!

On Fri, 29 Mar 2002, Art Wagner wrote:

> Hi;
> I seem to have the identical problem with system hangs on boot. The 
> problem I see occurs on a Abit BP6
> on the first access of the first drive on the HPT-366 interface. The 
> problem occurs on all -ac-x revisions
> 1 through 3.  The attached log is from an boot on 2.4.19-pre4 which did 
> not hang but the log is identical
> except for the fact that the hang occurs with only the "hde:" portion of 
> the last line displayed.
> If I can provide any further information pleas let me know via the list 
> or direct email.
> Art Wagner
> 
> Andre Hedrick wrote:
> 
> >On Fri, 29 Mar 2002, Alan Cox wrote:
> >
> >>>This is possible, however one of the problems encountered is the
> >>>following under several chipsets.  If there is no pio timing set at all,
> >>>then we can run into host lock issues if the driver drops out of dma.
> >>>Thus, if it is going to lockup here it would/could lock up in other
> >>>places when one trys to program the host for PIO.
> >>>
> >>Well right at the moment the ALi locks up on boot reliably. That means a
> >>fix has to be found, or the ALi changes reverted 
> >>
> >
> >Pull out the GOOF-UP of mine :-/
> >
> >autotune is enabled and does the same thing, Gurrr....
> >
> >Cheers,
> >
> >Andre Hedrick
> >LAD Storage Consulting Group
> >
> >-
> >To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> >the body of a message to majordomo@vger.kernel.org
> >More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >Please read the FAQ at  http://www.tux.org/lkml/
> >
> >
> 
> 

Andre Hedrick
LAD Storage Consulting Group

