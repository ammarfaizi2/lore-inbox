Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264173AbRFFVk6>; Wed, 6 Jun 2001 17:40:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264174AbRFFVki>; Wed, 6 Jun 2001 17:40:38 -0400
Received: from network.admin.crestech.ca ([132.251.1.3]:26375 "EHLO
	mailhub.CRESTech.ca") by vger.kernel.org with ESMTP
	id <S264173AbRFFVkb>; Wed, 6 Jun 2001 17:40:31 -0400
Date: Wed, 6 Jun 2001 17:40:28 -0400 (EDT)
From: Kipp Cannon <kipp@sgl.crestech.ca>
To: linux-kernel@vger.kernel.org
Subject: Re: temperature standard - global config option?
In-Reply-To: <9fm4sc$ggd$1@cesium.transmeta.com>
Message-ID: <Pine.GSO.4.05.10106061721140.27215-100000@s3.sgl.crestech.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

It seems that a lot of people are agreeing that the unit should be a
multiple of 1 kelvin but to my eyes there are two camps and I just want to
make sure that everyone's being clear with their notation.

If the kernel tells me the temperature is 1 (one) what should that mean?  
If it's spitting out 0.1*<temperature in K> as people are claiming the
ACPI stuff does then 1 means 10 kelvin or 1 dekakelvin, not a
                                            ^^^^
decikelvin as other people are saying they would prefer to see used.  Or
are people being braindamaged and by "0.1*K" they mean that ACPI spits out
10*<temperature in K>?  Which would then mean that everyone does agree
afterall that the unit should be a decikelvin although they don't
necessarily know what multiplication means :-).

							-Kipp

