Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264672AbSK0BnY>; Tue, 26 Nov 2002 20:43:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264673AbSK0BnX>; Tue, 26 Nov 2002 20:43:23 -0500
Received: from 200-203-38-237-paemt7006.dsl.telebrasilia.net.br ([200.203.38.237]:57606
	"EHLO vudu.ath.cx") by vger.kernel.org with ESMTP
	id <S264672AbSK0BnX>; Tue, 26 Nov 2002 20:43:23 -0500
Date: Tue, 26 Nov 2002 23:50:36 -0200 (BRST)
From: "Joao Alberto M. dos Reis (Listas de discucao)" <lista@vudu.ath.cx>
X-X-Sender: lista@goku.diretoria.org
To: Ben Greear <greearb@candelatech.com>
Cc: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>,
       Steven Dake <sdake@mvista.com>,
       lista do kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PROPOSAL] Network Load Balance
In-Reply-To: <3DE3F4F9.4090506@candelatech.com>
Message-ID: <Pine.LNX.4.44.0211262347470.8330-100000@goku.diretoria.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I know that in windows you need a capable ethernet adapter (Intel with
adaptive load balance feature) and the intel's load balance driver. Do I
have to have special hardware or driver to make the linux kernel's bonding?



On Tue, 26 Nov 2002, Ben Greear wrote:

> Jeff V. Merkey wrote:
> > Here is something we did at Novell many years back that worked very well for
> > load balancing across multiple adapters.  This implementation allowed up
> > to four (4) adapters to function with load balancing.  To pull this off,
> > you need to spoof at the MAC laer and alter the MAC addresses in the
> > header of received frames to spoof the IP stack above.  This method
> > requires **NO** changes to any protocol stacks above.
>
> How is this different from the bonding driver(s) that are already
> in the kernel?
>
> Also, round-robin type of things seem to cause trouble by re-ordering
> packets (as seen by the receiving machine).
>
> Ben
>
> --
> Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
> President of Candela Technologies Inc      http://www.candelatech.com
> ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear
>
>
>

