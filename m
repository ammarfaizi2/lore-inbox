Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290192AbSBFHgB>; Wed, 6 Feb 2002 02:36:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290228AbSBFHfv>; Wed, 6 Feb 2002 02:35:51 -0500
Received: from swazi.realnet.co.sz ([196.28.7.2]:49612 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S290192AbSBFHfI>; Wed, 6 Feb 2002 02:35:08 -0500
Date: Wed, 6 Feb 2002 09:28:22 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: Xavier Bestel <xavier.bestel@free.fr>
Cc: Pavel Machek <pavel@suse.cz>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Patrick Mochel <mochel@osdl.org>
Subject: Re: driverfs support for motherboard devices
In-Reply-To: <1012932692.27241.15.camel@bip>
Message-ID: <Pine.LNX.4.44.0202060927580.8308-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5 Feb 2002, Xavier Bestel wrote:

> le mar 05-02-2002 à 18:39, Pavel Machek a écrit :
> 
> > +void __init device_init_sys(void)
> > +{
> > +     sprintf(sys_iobus.name,"Bus for motherboard and strange devices");
> 
> Don't you fear that, with such a vague name, it'll end up being used as
> a generic thing where all not-well-defined hacks will end ? (à la
> procfs)

How about s/strange/system/

Regards,
	Zwane Mwaikambo


