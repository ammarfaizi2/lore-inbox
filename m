Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263935AbTH1Ldu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 07:33:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263940AbTH1Ldu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 07:33:50 -0400
Received: from [66.155.158.133] ([66.155.158.133]:4224 "EHLO
	ns.waumbecmill.com") by vger.kernel.org with ESMTP id S263935AbTH1Ldt convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 07:33:49 -0400
Content-Type: text/plain; charset=US-ASCII
From: joe briggs <jbriggs@briggsmedia.com>
Organization: BMS
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: binary kernel drivers re. hpt370 and redhat
Date: Thu, 28 Aug 2003 08:33:01 -0400
User-Agent: KMail/1.4.3
References: <200308271840.30368.jbriggs@briggsmedia.com> <20030827145755.7e1ce956.shemminger@osdl.org> <1062022619.23531.38.camel@dhcp23.swansea.linux.org.uk>
In-Reply-To: <1062022619.23531.38.camel@dhcp23.swansea.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200308280833.01136.jbriggs@briggsmedia.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I believe that companies will eventually see it costs less and the benefits 
higher to open source their drivers.  But that is a conclusion and paradigm 
that they will have to evolve to themselves, and shoving it down their 
throats will only lengthen the process.  The first step is to support their 
hardware under the platform (linux), and that is what I am focusing on.  

Thanks for the technical analysis and suggestions.

Joe

On Wednesday 27 August 2003 06:17 pm, you wrote:
> On Mer, 2003-08-27 at 22:57, Stephen Hemminger wrote:
> > On Wed, 27 Aug 2003 18:40:30 -0400
> >
> > joe briggs <jbriggs@briggsmedia.com> wrote:
> > > I have a client who has a raid controller currently supported under
> > > windows, and now wants to support linux as a bootable device. 
> > > Currently, some of their trade secrets are contained in the driver as
> > > opposed to the controller
>
> Standard practice - its not IMHO so much trade secrets as "improving the
> barrier to vendor change" 8). Pretty much all of the older PATA
> controllers don't actually do hardware raid but bios/driver raid - ie
> its the equivalent (or roughly so) of the md layer but locks you into
> the vendor. The notable exception here is the 3ware card (there are a
> couple of others too - Promise Supertrak100, SX6000)
>
> We know some of these formats (eg see the hptraid driver in 2.4.2x)
>
> > The problem is more in the bootloader (LILO or GRUB) would not no how
> > to do raid. The /boot partition would have to be on a non-raid partition.
> > Same problem if driver is statically linked in the kernel.
>
> Plus little issues like the GPL 8)

-- 
Joe Briggs
Briggs Media Systems
105 Burnsen Ave.
Manchester NH 01304 USA
TEL 603-232-3115 FAX 603-625-5809 MOBILE 603-493-2386
www.briggsmedia.com
