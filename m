Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271917AbRH2Gny>; Wed, 29 Aug 2001 02:43:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271918AbRH2Gnq>; Wed, 29 Aug 2001 02:43:46 -0400
Received: from as2-4-3.an.g.bonet.se ([194.236.34.191]:48629 "EHLO
	cosmo.zigo.dhs.org") by vger.kernel.org with ESMTP
	id <S271917AbRH2Gn3>; Wed, 29 Aug 2001 02:43:29 -0400
Date: Wed, 29 Aug 2001 08:42:35 +0200 (CEST)
From: Dennis Bjorklund <db@zigo.dhs.org>
To: Urban Widmark <urban@teststation.com>
cc: David Schmitt <david@heureka.co.at>, <linux-kernel@vger.kernel.org>
Subject: Re: ISSUE: DFE530-TX REV-A3-1 times out on transmit
In-Reply-To: <Pine.LNX.4.30.0108282034210.1851-200000@cola.teststation.com>
Message-ID: <Pine.LNX.4.33.0108290837470.15415-100000@cosmo.zigo.dhs.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Aug 2001, Urban Widmark wrote:

> > 2.2.19 with Dennis' patch
> >
> > Resets often, but no lock up.
>
> That is interesting. This code should be almost identical to 2.4.x (or
> not, Dennis?). The way the timeout code is run may be different of course,
> but the driver part is the same.

Well. I took (part of) the init code from 2.2.19 and used that for both
init and reset so there might be differences from 2.4.x. But the only
difference I remember that was really different, were some extra
spinlocks.

-- 
/Dennis

