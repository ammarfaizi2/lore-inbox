Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313181AbSHBMt1>; Fri, 2 Aug 2002 08:49:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313558AbSHBMt1>; Fri, 2 Aug 2002 08:49:27 -0400
Received: from mta4.srv.hcvlny.cv.net ([167.206.5.10]:40919 "EHLO
	mta4.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id <S313421AbSHBMt0>; Fri, 2 Aug 2002 08:49:26 -0400
Date: Fri, 02 Aug 2002 08:52:04 -0400
From: Nick Orlov <nick.orlov@mail.ru>
Subject: Re: [PATCH] pdc20265 problem.
In-reply-to: <1028291245.18317.15.camel@irongate.swansea.linux.org.uk>
To: lkml <linux-kernel@vger.kernel.org>
Mail-followup-to: lkml <linux-kernel@vger.kernel.org>
Message-id: <20020802125204.GA4729@nikolas.hn.org>
MIME-version: 1.0
Content-type: text/plain; charset=koi8-r
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: Mutt/1.4i
References: <Pine.LNX.4.44.0208010336330.1728-100000@freak.distro.conectiva>
 <20020802014728.GA796@nikolas.hn.org>
 <1028291245.18317.15.camel@irongate.swansea.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 02, 2002 at 01:27:25PM +0100, Alan Cox wrote:
> On Fri, 2002-08-02 at 02:47, Nick Orlov wrote:
> > 
> > > <marcelo@plucky.distro.conectiva> (02/07/19 1.646)
> > > 	Fix wrong #ifdef in ide-pci.c: Was causing problems with FastTrak
> > 
> > Because of this fix my Promise 20265 became ide0 instead of ide2.
> > Is there any reason to mark pdc20265 as ON_BOARD controller?
> 
> How about because it can be and it should be checked. I don't know what
> is going on with the ifdef in your case to cause this but its not as
> simple as it seems

Why pdc20265 is so special ? All other Promises marked as OFF_BOARD...

And what determines how id will be assigned to controllers if both of
them are ON_BOARD ?

-- 
With best wishes,
	Nick Orlov.

