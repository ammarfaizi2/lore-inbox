Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261762AbSJQDgy>; Wed, 16 Oct 2002 23:36:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261763AbSJQDgy>; Wed, 16 Oct 2002 23:36:54 -0400
Received: from adsl-67-64-81-217.dsl.austtx.swbell.net ([67.64.81.217]:26246
	"HELO digitalroadkill.net") by vger.kernel.org with SMTP
	id <S261762AbSJQDgw>; Wed, 16 Oct 2002 23:36:52 -0400
Subject: Re: [Kernel 2.5] Qlogic 2x00 driver
From: GrandMasterLee <masterlee@digitalroadkill.net>
To: Andrew Vasquez <praka@san.rr.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20021017031125.GA21251@praka.local.home>
References: <1034710299.1654.4.camel@localhost.localdomain>
	 <200210152153.08603.simon.roscic@chello.at>
	 <3DACD41F.2050405@metaparadigm.com> <1034740592.29313.0.camel@localhost>
	 <3DACEB6E.6050700@metaparadigm.com> <3DACEC85.3020208@tmsusa.com>
	 <3DACF908.70207@metaparadigm.com> <20021016054035.GM15552@clusterfs.com>
	 <20021017015903.GA20960@praka.local.home> <1034822651.27.3.camel@localhost>
	 <20021017031125.GA21251@praka.local.home>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Digitalroadkill.net
Message-Id: <1034826170.27.61.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.1.2.99 (Preview Release)
Date: 16 Oct 2002 22:42:50 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-10-16 at 22:11, Andrew Vasquez wrote:
...
> > Does this mean that 6.01 will NOT work either? What drivers will be
> > affected? We've already made the move to remove LVM from the mix, but
> > your comments above give me some doubt as to how definite it is, that
> > the stack clobbering will be fixed by doing so. 
> >

I was asking because We crashed, while using this driver, AND LVM. 
 
> The 6.x series driver basically branched from the 5.x series driver.  
> Changes made, many moons ago, are already in the 6.x series driver.
> To quell your concerns, yes, stack overflow is not an issue with the
> 6.x series driver. 
> 
> I believe if we are to get anywhere regarding this issue, we need to 
> shift focus from stack corruption in early versions of the driver.

In this way, you mean, that it is not an issue since you guys don't try
to use LVM.


> > > IAC, I believe the support tech working with MasterLee had asked 
> > > for additional information regarding the configuration as well as
> > > some basic logs.  Ideally we'd like to setup a similiar configuration
> > > in house and see what's happening...
> > 
> > In-house?
> > 
> Sorry, short introduction, Andrew Vasquez, Linux driver development at
> QLogic.

Nice to meet ya. :)

> > Just curious. What can "I" do to know if our configuration
> > won't get broken, just by removing LVM? TIA.
> >
> I've personally never used LVM before, so I cannot even begin to
> attempt to answer your question --  

We've removed LVM from the config, per Michael's issue and
recommendation, but I'm just scared that we *could* see this issue with
XFS and Qlogic. Since you're saying the 6.01 has no stack clobbering
issues, then is it XFS, LVM and Qlogic? 

> please work with the tech on this
> one, if it's a driver problem, we'd like to fix it.

I'm going to try, but we've got to get up and in production ASAP. Since
it takes *days* to cause the crash, I don't know how I can cause it  and
get the stack dump.

> --
> Andrew
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
