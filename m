Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263321AbSITR3h>; Fri, 20 Sep 2002 13:29:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263324AbSITR3d>; Fri, 20 Sep 2002 13:29:33 -0400
Received: from mikonos.cyclades.com.br ([200.230.227.67]:17162 "EHLO
	firewall.cyclades.com.br") by vger.kernel.org with ESMTP
	id <S263321AbSITR2T>; Fri, 20 Sep 2002 13:28:19 -0400
Content-Type: text/plain; charset=US-ASCII
From: henrique <henrique@cyclades.com.br>
Reply-To: henrique@cyclades.com
Organization: Cyclades Corporation
To: Kevin Curtis <kevin.curtis@farsite.co.uk>,
       "'Krzysztof Halasa'" <khc@pm.waw.pl>, linux-kernel@vger.kernel.org
Subject: Re: 2.4 + generic HDLC update? Any ideas?
Date: Fri, 20 Sep 2002 14:35:28 +0000
User-Agent: KMail/1.4.1
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Jeff Garzik <jgarzik@mandrakesoft.com>,
       Francois Romieu <romieu@cogenit.fr>, henrique@cyclades.com
References: <7C078C66B7752B438B88E11E5E20E72E0EF52B@GENERAL.farsite.co.uk>
In-Reply-To: <7C078C66B7752B438B88E11E5E20E72E0EF52B@GENERAL.farsite.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200209201435.28681.henrique@cyclades.com.br>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello !!!

As Kevin, we also use the generic HDLC by patch. Moreover the PC300 driver is 
a patch too (it was oficially patched to the kernel just in the 2.5 serie). 
It would very good to have the new generic HDLC in the kernel 2.4 as most of 
our customers uses the 2.4 serie and most of them have no idea what is a 
patch. I don't see problems with the configuration utility because our 
customers install it from the sources provided by us and it is just a matter 
of change the sources.

kind regards
---
Henrique Gobbi
Software Engineer
+55 11 50333339
Cyclades Corporation

On Friday 20 September 2002 03:18 pm, Kevin Curtis wrote:
> Hi,
> 	we use the generic HDLC module (by patch) in 2.4 with our FarSync
> card.  I would be happy for it to be incorporated into the 2.4 Kernel.  We
> don't use sethdlc, we have our own configuration utility.
>
> 	We are finding that some distro's are now incorporating the patch
> anyway (Mandrake for example), and some of our customers are getting
> confused when the patch doesn't install cleanly because it is already
> there. Especially if the customer doesn't understand patch anyway and is
> just following install instructions.
>
> 	What 2.4 version would you aim for?
>
>
> Kevin Curtis
> Linux Development
> FarSite Communications Ltd
> kevin.curtis@farsite.co.uk
> tel:   +44 1256 330461
> fax:  +44 1256 854931
> http://www.farsite.co.uk
>
>
> -----Original Message-----
> From: Krzysztof Halasa [mailto:khc@pm.waw.pl]
> Sent: 19 September 2002 14:33
> To: linux-kernel@vger.kernel.org
> Cc: Alan Cox; Jeff Garzik; Francois Romieu; henrique@cyclades.com
> Subject: 2.4 + generic HDLC update? Any ideas?
>
>
> Hi,
>
> The question is probably aimed mainly at people maintaining 2.4 Linux
> and/or networking, but I'd like to see an opinion of other users/
> developers as well.
>
> What do you think about updating the 2.4 generic HDLC layer to the
> newer 2.5 code?
>
> Facts:
> - it would break all sethdlc compatibility, users would be required to
>   get 2.5 sethdlc.c and recompile it. There are even cosmetic sethdlc
>   syntax changes and additions (sethdlc is a configuration tool).
> - it would make it possible to support new boards like Cyclades PC300
>   (not only this one).
> - drivers which are in current 2.4 include Moxa C101 and RISCom/N2,
>   which are older ISA cards. Most of their users currently use 2.5
>   generic HDLC (a patch) with 2.4 kernels anyway.
> - the other driver affected is DSCC4, but I know exactly nothing about
>   it (a 2.5 version of it is, of course, available). What do you think,
>   Francois?
>
> The update, if any, wouldn't take place yet. I would expect it to happen
> after some remaining questions regarding 2.5 code are resolved - chances
> are there will be small changes to 2.5 generic HDLC interface first.

-- 

