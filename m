Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263055AbVCQOdi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263055AbVCQOdi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 09:33:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263076AbVCQOdi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 09:33:38 -0500
Received: from ZIVLNX17.UNI-MUENSTER.DE ([128.176.188.79]:15763 "EHLO
	ZIVLNX17.uni-muenster.de") by vger.kernel.org with ESMTP
	id S263055AbVCQOdf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 09:33:35 -0500
From: Borislav Petkov <petkov@uni-muenster.de>
To: "Barry K. Nathan" <barryn@pobox.com>
Subject: Re: 2.6.11-mm4
Date: Thu, 17 Mar 2005 15:07:50 +0100
User-Agent: KMail/1.7.2
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20050316040654.62881834.akpm@osdl.org> <200503171207.56147.petkov@uni-muenster.de> <20050317134147.GA5410@ip68-4-98-123.oc.oc.cox.net>
In-Reply-To: <20050317134147.GA5410@ip68-4-98-123.oc.oc.cox.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200503171507.50734.petkov@uni-muenster.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 17 March 2005 14:41, Barry K. Nathan wrote:
> On Thu, Mar 17, 2005 at 12:07:55PM +0100, Borislav Petkov wrote:
> > Hi again,
> >
> > since I don't have a 9-pin serial port on my laptop I've been trying to
> > connect it with the testing machine over a 25-pin cable (on a 25-pin
> > port), which, according to the Serial-HOWTO is doable in theory but
> > doesn't seem that easy to do in practice. Setserial reports that the
> > ports are ok:
>
> On laptops, 25-pin ports tend to be parallel, rather than serial. At
> least, that's my experience.
And this is the truth, actually. It is :( a parallel port.
>
> [snip]
>
> > but minicom or other serial line communication utils do not send or
> > receive any chars. Any ideas?
>
> Hook a printer up to the 25-pin port (the other end of the cable will
> most likely have 36 pins), then use (I think, it's been a while)
> /dev/lp0 as your console device, rather than /dev/ttyS#. This assumes
> that your kernel has parallel console support compiled in, and that
> the parallel port support is compiled in (as opposed to being a module).
>
> And if you do the above, make sure to have lots of paper handy. Also,
> this trick probably won't work with all printers, but it stands a good
> chance of working.
This is an option but I don't have a printer right now so I think I'll go with 
another idea a guy gave me on our laptop forum - USB to serial adapter, it is 
relatively cheap (~20€ in Germany) and trivial to install. Still, thanks for 
your help, I'll be reporting as soon as I get the gadget.

Boris.
>
> -Barry K. Nathan <barryn@pobox.com>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
