Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289441AbSAJNhn>; Thu, 10 Jan 2002 08:37:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289440AbSAJNhd>; Thu, 10 Jan 2002 08:37:33 -0500
Received: from twilight.cs.hut.fi ([130.233.40.5]:63142 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S289441AbSAJNhX>; Thu, 10 Jan 2002 08:37:23 -0500
Date: Thu, 10 Jan 2002 15:37:02 +0200
From: Ville Herva <vherva@niksula.hut.fi>
To: Henrique de Moraes Holschuh <hmh@debian.org>
Cc: linux-kernel@vger.kernel.org, Jani Forssell <jani.forssell@viasys.com>
Subject: Re: Via KT133 pci corruption: stock 2.4.18pre2 oopses as well
Message-ID: <20020110133702.GB34841@niksula.cs.hut.fi>
In-Reply-To: <20020109235722.L1200@niksula.cs.hut.fi> <Pine.LNX.4.21.0201100025440.14057-100000@tux.rsn.bth.se> <20020110100101.A25366@khazad-dum>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020110100101.A25366@khazad-dum>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2002 at 10:01:02AM -0200, you [Henrique de Moraes Holschuh] claimed:
> 
> The IDE corruption and lockups you can fix, just apply the latest IDE
> patches, the 2.4.18pre IDE subsystem is not to be used on a KT133, it will
> not work at all if you give it a slightly bigger load on the promise
> controller, for example.

We just tried with 2.4.18pre2 + Hedrick ATA patch, but it oopsed just like
2.4.18pre2 vanilla. I reckon the ide corruption will also happen if we leave
the "ping -f" out of the equation.

This is propably a pci issue, not an ide issue.

 
-- v --

v@iki.fi
