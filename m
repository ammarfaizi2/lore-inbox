Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261724AbVANCV0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261724AbVANCV0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 21:21:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261749AbVANCV0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 21:21:26 -0500
Received: from [209.195.52.120] ([209.195.52.120]:12274 "HELO
	warden2.diginsite.com") by vger.kernel.org with SMTP
	id S261724AbVANCVX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 21:21:23 -0500
Date: Thu, 13 Jan 2005 18:20:55 -0800 (PST)
From: David Lang <dlang@digitalinsight.com>
X-X-Sender: dlang@dlang.diginsite.com
To: John covici <covici@ccs.covici.com>
cc: Helge Hafting <helge.hafting@hist.no>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.10 dies when X tries to initialize PCI radeon 9200 SE
In-Reply-To: <16870.21720.866418.326325@ccs.covici.com>
Message-ID: <Pine.LNX.4.60.0501131820230.20576@dlang.diginsite.com>
References: <41E64DAB.1010808@hist.no> <16870.21720.866418.326325@ccs.covici.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I ran into a similar problem with 2.6.8.1 and found that by downgrading to 
AGP4 I could get it to work.

DAvid Lang

On Thu, 13 Jan 2005, John covici wrote:

> Date: Thu, 13 Jan 2005 06:00:40 -0500
> From: John covici <covici@ccs.covici.com>
> To: Helge Hafting <helge.hafting@hist.no>
> Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
> Subject: 2.6.10 dies when X tries to initialize PCI radeon 9200 SE
> 
> I am getting something similar -- the X process gets stuck in some
> kind of system call, but I can login from the network and shut the
> system down, but I cannot change the console from the X to a text
> console.
>
> on Thursday 01/13/2005 Helge Hafting(helge.hafting@hist.no) wrote
> > 2.6.10 boots fine, but is killed by the X server when it
> > tries to initialize my PCI radeon 9200 SE.  This problem exists
> > in 2.6.9 too, but not in 2.6.8.1.  So I'm stuck with that version currently.
> >
> > The problem seems to be access to the card bios, X uses
> > int10 bios calls to initialize the card.
> >
> > Helge Hafting
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
>
> --
>         John Covici
>         covici@ccs.covici.com
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

-- 
There are two ways of constructing a software design. One way is to make it so simple that there are obviously no deficiencies. And the other way is to make it so complicated that there are no obvious deficiencies.
  -- C.A.R. Hoare
