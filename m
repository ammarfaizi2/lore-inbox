Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264623AbUEEMsL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264623AbUEEMsL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 May 2004 08:48:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264625AbUEEMsL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 May 2004 08:48:11 -0400
Received: from gizmo09bw.bigpond.com ([144.140.70.19]:28332 "HELO
	gizmo09bw.bigpond.com") by vger.kernel.org with SMTP
	id S264623AbUEEMsE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 May 2004 08:48:04 -0400
From: Ross Dickson <ross@datscreative.com.au>
Reply-To: ross@datscreative.com.au
Organization: Dat's Creative Pty Ltd
To: Ian Kumlien <pomac@vapor.com>
Subject: Re: IO-APIC on nforce2 [PATCH] + [PATCH] for nmi_debug=1 + [PATCH] for idle=C1halt, 2.6.5
Date: Wed, 5 May 2004 22:52:29 +1000
User-Agent: KMail/1.5.1
Cc: Allen Martin <AMartin@nvidia.com>, linux-kernel@vger.kernel.org,
       Len Brown <len.brown@intel.com>, Jesse Allen <the3dfxdude@hotmail.com>,
       "Prakash K. Cheemplavam" <PrakashKC@gmx.de>,
       Craig Bradney <cbradney@zip.com.au>, christian.kroener@tu-harburg.de,
       "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
       Jamie Lokier <jamie@shareable.org>, Daniel Drake <dan@reactivated.net>
References: <DCB9B7AA2CAB7F418919D7B59EE45BAF49FC2D@mail-sc-6-bk.nvidia.com> <200405052124.55515.ross@datscreative.com.au> <1083759539.2797.24.camel@big>
In-Reply-To: <1083759539.2797.24.camel@big>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200405052252.29359.ross@datscreative.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 05 May 2004 22:18, Ian Kumlien wrote:
> On Wed, 2004-05-05 at 13:24, Ross Dickson wrote:
> <snip>
> > They can't see through their Windows.??!@@#$$%%&*&
> > 
> > ML1-0505-19 Re: Cause of lockups with KM-18G Pro is incorrect pci reg values in bios -please update bios
> > 
> > From: 
> > "dr.pro" <dr.pro@albatron.com.tw>
> > 
> > To: 
> > <ross@datscreative.com.au>
> > 
> > Date: 
> > Today 17:38:08
> > 
> >   Dear Ross,
> > 
> >   Thank you very much for contacting Albatron technical support.
> > 
> >   KM18G Pro has been proved under Windows 98SE/ME/2000/XP but Linux, so you
> > may encounter problems with it under Linux. We suggest you use Windows
> > 98SE/ME/2000/XP for the stable performance. Sorry for the inconvenience and
> > please kindly understand it.
> > 
> >   Please let us know if you have any question.
> 
> Please kindly understand it? I wouldn't... I'm about to bash asus, so...
> This information gets me in the moood to do some real bashing =)
> 
> Btw, does windows do a C1 disconnect? And if so how often?

I think it does as temps are lower then linux without disconnect.
Here are some temperatures from my machine read from the bios on reboot.
I gave it minimal activity for the minutes prior to reboot.

 Win98, 47C
 XPHome, 42C
 Patched Linux 2.4.24 (1000Hz), 40C
 Linux 2.6.3-rc1-mm1, 53C  with no disconnect
 
I think the disconnect happens for less time percentage. With slower
ticks one might assume less often than linux. 
-Ross

> 
> -- 
> Ian Kumlien <pomac () vapor ! com> -- http://pomac.netswarm.net
> 

