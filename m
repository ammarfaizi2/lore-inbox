Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265442AbUBFNet (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 08:34:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265443AbUBFNes
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 08:34:48 -0500
Received: from mailhst2.its.tudelft.nl ([130.161.34.250]:60119 "EHLO
	mailhst2.its.tudelft.nl") by vger.kernel.org with ESMTP
	id S265442AbUBFNer convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 08:34:47 -0500
Date: Fri, 6 Feb 2004 14:34:39 +0100 (MET)
From: Arjen Verweij <A.Verweij2@ewi.tudelft.nl>
Reply-To: a.verweij@student.tudelft.nl
To: Craig Bradney <cbradney@zip.com.au>
cc: "Prakash K. Cheemplavam" <PrakashKC@gmx.de>,
       Daniel Drake <dan@reactivated.net>,
       Luis Miguel =?ISO-8859-1?Q?Garc=EDa?= <ktech@wanadoo.es>,
       <david+challenge-response@blue-labs.org>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [ACPI] acpi problem with nforce motherboards and ethernet
In-Reply-To: <1076071864.1036.3.camel@athlonxp.bradney.info>
Message-ID: <Pine.GHP.4.44.0402061433510.7943-100000@elektron.its.tudelft.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It would probably be more useful if I included the URL as well duh... (thx
Craig)

http://atlas.et.tudelft.nl/verwei90/nforce2/
http://atlas.et.tudelft.nl/verwei90/nforce2/index.html

both should work.

On Fri, 6 Feb 2004, Craig Bradney wrote:

> On Fri, 2004-02-06 at 12:15, Prakash K. Cheemplavam wrote:
> > Prakash K. Cheemplavam wrote:
> > > Daniel Drake wrote:
> > >
> > >> Prakash K. Cheemplavam wrote:
> > >>
> > >>> Ok, then it makes sense, so you are using APIc with CPU Disconnect
> > >>> and Ross' patch. This explains your low idle temps. As I said this
> > >>> config doesn't work for me.
> > >>
> > >>
> > >>
> > >> Have you experimented with the new apic_tack boot options in Ross's
> > >> latest patches?
> > >> apic_tack=2 seems to work best for me.
> > >
> > >
> > > Stupid me. I haven't thoruoughly read the text. I have not activated the
> > > patch, so I'll try this. thx for pointing out..
> >
> > OK, I appended apic_tack=2 and yes, it survives several hdparms! Great,
> > so gonna try if it is really stable.Then I can try =1. CPU cooling down.
> > Already at 46°C. :-)
> >
> > Not bad,not bad, though I saw a small performace degration: hdparm gives
> > me 60-61mb/s instead of >62mb/s, but I won't complain. :-)
> >
>
> Ahh yes.. missing the kernel line argument will make a difference. I'm
> running apic_tack=2 as well. From what I remember =2 was the "better"
> patch option if it made your system stable.
>
> Craig
>

