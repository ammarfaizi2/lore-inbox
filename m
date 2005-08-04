Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262497AbVHDMSr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262497AbVHDMSr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 08:18:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262493AbVHDMQo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 08:16:44 -0400
Received: from mail18.syd.optusnet.com.au ([211.29.132.199]:57013 "EHLO
	mail18.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S262497AbVHDMJL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 08:09:11 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux-kernel@vger.kernel.org
Subject: Re: [ck] [ANNOUNCE] Interbench 0.27
Date: Thu, 4 Aug 2005 22:04:57 +1000
User-Agent: KMail/1.8.2
Cc: Gabriel Devenyi <ace@staticwave.ca>, ck@vds.kolivas.org,
       Jake Moilanen <moilanen@austin.ibm.com>
References: <200508031758.31246.kernel@kolivas.org> <200508042146.13710.kernel@kolivas.org> <42F2047A.1050906@staticwave.ca>
In-Reply-To: <42F2047A.1050906@staticwave.ca>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508042204.57977.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Aug 2005 22:05, Gabriel Devenyi wrote:
> Con Kolivas wrote:
> > I have to think about it. This seems a problem only on one type of cpu
> > for some strange reason (lemme guess; athlon?) and indeed leaving out the
> > sleep 1 followed by the check made results far less reliable. This way
> > with the sleep 1 I have not had spurious results returned by the
> > calibration. I'm open to suggestions if anyone's got one.
>
> Yeah, thats right, it spins forever on both my athlon-tbird and my
> athlon64 (in x86_64 mode). I'll take another look at the code tonight,
> to see if I can figure out why its causing this, or another way of
> incurring the delay you're looking for.

I'd appreciate it. It's almost like some power stepping that's responsible. 
I've never seen it happen on any intel processor (including the pentiumM ones 
which have truckloads of power saving features). I've asked many people if 
they're running some equivalent of cool'n'quiet or powernow* and they all 
insist they're not... I'm not that familiar with all the powersaving techs 
though.

Cheers,
Con
