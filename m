Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264245AbRFFX2H>; Wed, 6 Jun 2001 19:28:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264249AbRFFX16>; Wed, 6 Jun 2001 19:27:58 -0400
Received: from p4.nas4.is5.u-net.net ([195.102.201.132]:1012 "EHLO
	keston.u-net.com") by vger.kernel.org with ESMTP id <S264245AbRFFX1w>;
	Wed, 6 Jun 2001 19:27:52 -0400
Message-ID: <015201c0eee0$4a6a9d80$1901a8c0@node0.idium.eu.org>
From: "David Flynn" <Dave@keston.u-net.com>
To: "Maciej Zenczykowski" <maze@druid.if.uj.edu.pl>,
        "Kipp Cannon" <kipp@sgl.crestech.ca>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0106070057001.31904-100000@druid.if.uj.edu.pl>
Subject: Re: temperature standard - global config option?
Date: Thu, 7 Jun 2001 00:27:44 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
X-MDRemoteIP: 192.168.1.25
X-Return-Path: Dave@keston.u-net.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wed, 6 Jun 2001, Kipp Cannon wrote:
>
> > If the kernel tells me the temperature is 1 (one) what should that mean?
> > If it's spitting out 0.1*<temperature in K> as people are claiming the
> > ACPI stuff does then 1 means 10 kelvin or 1 dekakelvin, not a
> >                                             ^^^^
> > decikelvin as other people are saying they would prefer to see used.  Or
> > are people being braindamaged and by "0.1*K" they mean that ACPI spits
out
> > 10*<temperature in K>?  Which would then mean that everyone does agree
> > afterall that the unit should be a decikelvin although they don't
> > necessarily know what multiplication means :-).
>
> I do believe that by 0.1*K everyone means a basic unit of 0.1 K, i.e. with
> an int of 1 meaning 0.1 Kelvin, analogically 0.01*K meaning an int of 1
> means 0.01 Kelvin - hence the proper names of deci and centi-Kelvins.
>
> Perosnally I believe we should take normal (32 bit) ints (perhaps more on
> 64bit architectures?) and encode using 0.001*K (i.e. miliKelvins),

One question here which has been bugging me all through this thread, is
there any hardware that actually measures to that precision and accuracy ??
certanally 0.1K intervals, but 0.01 ?, and at 0.001K intervals ? is this
going ott ? and what use would people have with measureing system temp to
0.01K precision ? --i would assume that the accuracy of the temp sensors is
less than that...

well, there are my two cents ...


> I do believe space is not an issue here and this leaves us the most
> precision and logical system - Farenhait is screwed, and
> Celsius/Centigrade are not to good since don't begin at absolute zero.
>

Farenhait is irritating, yes, and the brits that suggested it are becoming a
dying bread, although still large in number, things more so use Celsius
nowerdays.

btw, the kelvin scale is a centigrade scale, like wise, so is the celsius
scale ...


Thanks,,
Dave

> Anyway just my two cents.
>
> Maciej.
>


