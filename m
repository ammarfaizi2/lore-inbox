Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261693AbTCZNm2>; Wed, 26 Mar 2003 08:42:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261695AbTCZNm2>; Wed, 26 Mar 2003 08:42:28 -0500
Received: from CPE0080c8c9b431-CM014280010574.cpe.net.cable.rogers.com ([24.114.72.97]:53769
	"EHLO stargate.coplanar.net") by vger.kernel.org with ESMTP
	id <S261693AbTCZNm1>; Wed, 26 Mar 2003 08:42:27 -0500
Subject: Re: Preferred way to load non-free firmware
From: Jeremy Jackson <jerj@coplanar.net>
To: oliver@neukum.name
Cc: Nick Craig-Wood <ncw1@axis.demon.co.uk>, Greg KH <greg@kroah.com>,
       Pavel Roskin <proski@gnu.org>, linux-kernel@vger.kernel.org
In-Reply-To: <200303261347.27137.oliver@neukum.org>
References: <Pine.LNX.4.50.0303252007420.6656-100000@marabou.research.att.com>
	 <20030326041146.GD20858@kroah.com>
	 <20030326104856.GA31375@axis.demon.co.uk>
	 <200303261347.27137.oliver@neukum.org>
Content-Type: text/plain; charset=UTF-8
Organization: 
Message-Id: <1048686722.1248.6.camel@contact.skynet.coplanar.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 26 Mar 2003 08:52:03 -0500
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Check the list archive, there was someone telling about support they
added for binary blobs in /proc (or was it sysfs?) for this (among
others) very purpose.

Please don't make the situation any worse.  I'd like to have some hope
that Debian my publish their kernel-source package with a
linux-x.x.x.tar.bz2 that matches the md5sum of the one on kernel.org
some day.

Regards,

Jeremy

On Wed, 2003-03-26 at 07:47, Oliver Neukum wrote:
> Am Mittwoch, 26. März 2003 11:48 schrieb Nick Craig-Wood:
> > On Tue, Mar 25, 2003 at 08:11:46PM -0800, Greg KH wrote:
> > > > 7) Encode the firmware into a header file, add it to the driver and
> > > > pretend that the copyright issue doesn't exist (like it's done in the
> > > > Keyspan USB driver).
> > >
> > > Hey, that's the way I like doing this stuff :)
> >
> > If you do this the Debian kernel mainainers will mercilessly rip your
> > non-free driver firmware from the standard Debian kernel.  At least
> > that is what happened with the Keyspan :-(
> 
> That's their problem then. Or rather their users.
> IMHO a maintainer's responsibility ends at kernel.org.
> >From a technical point of view the firmware needs to be
> in ram when you resume from sleep. If you don't care about
> updating it, having it in the kernel image uses somewhat less
> resources. So I'd say go for it.
> 
> 	Regards
> 		Oliver
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

