Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267318AbTABWet>; Thu, 2 Jan 2003 17:34:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267320AbTABWet>; Thu, 2 Jan 2003 17:34:49 -0500
Received: from linux.kappa.ro ([194.102.255.131]:34214 "EHLO linux.kappa.ro")
	by vger.kernel.org with ESMTP id <S267318AbTABWeq>;
	Thu, 2 Jan 2003 17:34:46 -0500
Date: Fri, 3 Jan 2003 00:42:46 +0200
From: Teodor Iacob <Teodor.Iacob@astral.kappa.ro>
To: Ross Biro <rossb@google.com>
Cc: Lionel Bouton <Lionel.Bouton@inet6.fr>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Andre Hedrick <andre@linux-ide.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: UDMA 133 on a 40 pin cable
Message-ID: <20030102224246.GA429@linux.kappa.ro>
References: <20030102182932.GA27340@linux.kappa.ro> <1041536269.24901.47.camel@irongate.swansea.linux.org.uk> <3E14B698.8030107@inet6.fr> <3E14BFD4.7000909@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E14BFD4.7000909@google.com>
User-Agent: Mutt/1.3.25i
X-RAVMilter-Version: 8.3.0(snapshot 20011220) (linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok then after all .. what I see on my box could be a stupid IDE controller?

On Thu, Jan 02, 2003 at 02:40:20PM -0800, Ross Biro wrote:
> >
> >#1 How is the 40/80 pin detection done at the hardware level ?
> 
> 
> On the motherboard end of the 80 conductor cable, the connector shorts 
> one of the pins to ground (maybe pin 38).  The ide controller  just 
> checks to see if the pin is pulled low or not.  Pulled low = 80 pin. 
> That's one of the reasons it's important to plug IDE cables in the 
> correct way.
> 
>    Ross
> 

-- 
      Teodor Iacob,
Network Administrator
Astral TELECOM Internet
