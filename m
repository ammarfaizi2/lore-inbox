Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129226AbQLBAS5>; Fri, 1 Dec 2000 19:18:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129231AbQLBASi>; Fri, 1 Dec 2000 19:18:38 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:54788 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129226AbQLBASe>; Fri, 1 Dec 2000 19:18:34 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: IP fragmentation (DF) and ip_no_pmtu_disc in 2.2 vs 2.4
Date: 1 Dec 2000 15:47:25 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <909dad$2uk$1@cesium.transmeta.com>
In-Reply-To: <E141v36-0000Zg-00@the-village.bc.nu> <Pine.LNX.4.30.0012011902010.5623-100000@rossi.itg.ie>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2000 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.LNX.4.30.0012011902010.5623-100000@rossi.itg.ie>
By author:    Paul Jakma <paulj@itg.ie>
In newsgroup: linux.dev.kernel
>
> On Fri, 1 Dec 2000, Alan Cox wrote:
> 
> > > Intel PXE uses tftp to download boot images and discards IP packets with
> > > the DF bit set; so a tftpd server on 2.4 with the default
> >
> > Then Intel PXE is buggy and you should go spank whoever provided
> > it as well as doing the workarounds. Supporting received frames
> > with DF set is mandatory.
> >
> 

Intel PXE is buggier than hell.  Don't even get me started.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
