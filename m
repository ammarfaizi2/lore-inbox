Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264232AbRFFXCD>; Wed, 6 Jun 2001 19:02:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264234AbRFFXBy>; Wed, 6 Jun 2001 19:01:54 -0400
Received: from druid.if.uj.edu.pl ([149.156.64.221]:14085 "HELO
	druid.if.uj.edu.pl") by vger.kernel.org with SMTP
	id <S264232AbRFFXBn>; Wed, 6 Jun 2001 19:01:43 -0400
Date: Thu, 7 Jun 2001 01:02:32 +0200 (CEST)
From: Maciej Zenczykowski <maze@druid.if.uj.edu.pl>
To: Kipp Cannon <kipp@sgl.crestech.ca>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: temperature standard - global config option?
In-Reply-To: <Pine.GSO.4.05.10106061721140.27215-100000@s3.sgl.crestech.ca>
Message-ID: <Pine.LNX.4.33.0106070057001.31904-100000@druid.if.uj.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Jun 2001, Kipp Cannon wrote:

> If the kernel tells me the temperature is 1 (one) what should that mean?
> If it's spitting out 0.1*<temperature in K> as people are claiming the
> ACPI stuff does then 1 means 10 kelvin or 1 dekakelvin, not a
>                                             ^^^^
> decikelvin as other people are saying they would prefer to see used.  Or
> are people being braindamaged and by "0.1*K" they mean that ACPI spits out
> 10*<temperature in K>?  Which would then mean that everyone does agree
> afterall that the unit should be a decikelvin although they don't
> necessarily know what multiplication means :-).

I do believe that by 0.1*K everyone means a basic unit of 0.1 K, i.e. with
an int of 1 meaning 0.1 Kelvin, analogically 0.01*K meaning an int of 1
means 0.01 Kelvin - hence the proper names of deci and centi-Kelvins.

Perosnally I believe we should take normal (32 bit) ints (perhaps more on
64bit architectures?) and encode using 0.001*K (i.e. miliKelvins),
I do believe space is not an issue here and this leaves us the most
precision and logical system - Farenhait is screwed, and
Celsius/Centigrade are not to good since don't begin at absolute zero.

Anyway just my two cents.

Maciej.

