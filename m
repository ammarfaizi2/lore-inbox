Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276229AbRJCNYK>; Wed, 3 Oct 2001 09:24:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276223AbRJCNX6>; Wed, 3 Oct 2001 09:23:58 -0400
Received: from ns.suse.de ([213.95.15.193]:49157 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S276211AbRJCNXs> convert rfc822-to-8bit;
	Wed, 3 Oct 2001 09:23:48 -0400
Date: Wed, 3 Oct 2001 15:24:16 +0200 (CEST)
From: Dave Jones <davej@suse.de>
To: =?iso-8859-1?Q?Ragnar_Kj=F8rstad?= <kernel@ragnark.vestdata.no>
Cc: Rik van Riel <riel@conectiva.com.br>,
        "sebastien.cabaniols" <sebastien.cabaniols@laposte.net>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [POT] Which journalised filesystem ?
In-Reply-To: <20011003150145.D8709@vestdata.no>
Message-ID: <Pine.LNX.4.30.0110031519320.16788-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Oct 2001, Ragnar Kjørstad wrote:

> If a disk is doing write-back caching, it's likely to break all
> journaling filesystem and anything else that relies on write ordering.

Yup, I know this *now* :-)
My point is that I had no idea the drive was doing write-caching.

hdparm only offers an option to set it to on/off, not to query it.
Just disabling it in a boot up script *might* be enough to make this
safe again, but I've not looked at the hdparm & IDE code, so this
is just a theory.

regards,

Dave.

-- 
| Dave Jones.        http://www.suse.de/~davej
| SuSE Labs

