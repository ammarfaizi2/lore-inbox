Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264790AbSKRUsC>; Mon, 18 Nov 2002 15:48:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264795AbSKRUsC>; Mon, 18 Nov 2002 15:48:02 -0500
Received: from 015.atlasinternet.net ([212.9.93.15]:27847 "EHLO
	antoli.gallimedina.net") by vger.kernel.org with ESMTP
	id <S264790AbSKRUsA>; Mon, 18 Nov 2002 15:48:00 -0500
Content-Type: text/plain; charset=US-ASCII
From: Ricardo Galli <gallir@uib.es>
Organization: UIB
To: Dave Jones <davej@codemonkey.org.uk>
Subject: Re: PATCH: Recognize Tualatin cache size in 2.4.x
Date: Mon, 18 Nov 2002 21:54:52 +0100
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org, marcelo@conectiva.com.br
References: <200211171549.gAHFnSrE021923@mnm.uib.es> <20021118190200.GA20936@suse.de>
In-Reply-To: <20021118190200.GA20936@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200211182154.52081.gallir@uib.es>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 18 November 2002 20:02, Dave Jones shaped the electrons to shout:
> On Sun, Nov 17, 2002 at 04:55:22PM +0100, Ricardo Galli wrote:
>  > Marcelo,
>  > 	please attach this patch to recognise the Tualatin processors'
>  > cache.
>  >
>  > I think this has been already discussed in the list, and DaveJ
>  > also applied it in his tree and/or 2.5.x. It is documented by
>  > Intel.
>
> I sent Marcelo a patch containing this and other IDs.
> He wants to take it for .21pre1
>
> It's purely cosmetic, so that's fine with me..

It's very cosmetic but very annoying for P3 > 1GHz, where Linux <= 2.4.20-preX 
only reports 32 KB of cache and it also seems to ignore the "cachesize" 
parameter. Perhaps it really uses 256KB, but not sure.

I tested it in a Compaq Proliant 330ML-G2 (P3 1.4) and a kernel compilation is 
100% faster if the patch is applied.

Regards, 

PS: Dave, see you in Mallorca in 20 days :-)

-- 
  ricardo galli       GPG id C8114D34

