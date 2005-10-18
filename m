Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932416AbVJRGok@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932416AbVJRGok (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 02:44:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751443AbVJRGok
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 02:44:40 -0400
Received: from smtp110.sbc.mail.re2.yahoo.com ([68.142.229.95]:45476 "HELO
	smtp110.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1751441AbVJRGoj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 02:44:39 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: 2.6.14-rc4-mm1
Date: Tue, 18 Oct 2005 01:44:35 -0500
User-Agent: KMail/1.8.2
Cc: Andrew Morton <akpm@osdl.org>, Brice Goglin <Brice.Goglin@ens-lyon.org>,
       linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>
References: <20051016154108.25735ee3.akpm@osdl.org> <d120d5000510171439l556be0d7sccb7f3c0e65d07bd@mail.gmail.com> <20051018063941.GA7104@midnight.suse.cz>
In-Reply-To: <20051018063941.GA7104@midnight.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200510180144.36252.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 18 October 2005 01:39, Vojtech Pavlik wrote:
> On Mon, Oct 17, 2005 at 04:39:52PM -0500, Dmitry Torokhov wrote:
> > On 10/17/05, Vojtech Pavlik <vojtech@suse.cz> wrote:
> > > On Mon, Oct 17, 2005 at 01:22:42PM -0700, Andrew Morton wrote:
> > > > Brice Goglin <Brice.Goglin@ens-lyon.org> wrote:
> > > > >
> > > > > Le 17.10.2005 00:41, Andrew Morton a écrit :
> > > > > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.14-rc4/2.6.14-rc4-mm1/
> > > > > >
> > > > > > - Lots of i2c, PCI and USB updates
> > > > > >
> > > > > > - Large input layer update to convert it all to dynamic input_dev allocation
> > > > > >
> > > > > > - Significant x86_64 updates
> > > > > >
> > > > > > - MD updates
> > > > > >
> > > > > > - Lots of core memory management scalability rework
> > > > >
> > > > > Hi Andrew,
> > > > >
> > > > > I got the following oops during the boot on my laptop (Compaq Evo N600c).
> > > > > .config is attached.
> > > > >
> > > > > Regards,
> > > > > Brice
> > >
> > > Where did get support for IBM TrackPoints into that kernel? It's
> > > certainly not in 2.6.14, and it's not in the -mm patch either ...
> > >
> > 
> > Yes it is. We merged it at the beginning of 2.6.14.. ;)
> 
> Ahh, sorry. I've seen it cause trouble so many times before I forgot we
> actually did merge it.
>

Really? It seems to be working perfectly on my laptop...
 
-- 
Dmitry
