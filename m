Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261615AbSLZPFq>; Thu, 26 Dec 2002 10:05:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261724AbSLZPFp>; Thu, 26 Dec 2002 10:05:45 -0500
Received: from smtp09.iddeo.es ([62.81.186.19]:63125 "EHLO smtp09.retemail.es")
	by vger.kernel.org with ESMTP id <S261615AbSLZPFp>;
	Thu, 26 Dec 2002 10:05:45 -0500
Date: Thu, 26 Dec 2002 16:13:58 +0100
From: =?iso-8859-1?Q?J=2EA=2E_Magall=F3n?= <jamagallon@able.es>
To: linux-kernel@vger.kernel.org
Cc: Andrea Arcangeli <andrea@suse.de>
Subject: Re: 2.4.21pre2aa1
Message-ID: <20021226151358.GA1607@werewolf.able.es>
References: <20021226010605.GA4223@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20021226010605.GA4223@dualathlon.random>; from andrea@suse.de on Thu, Dec 26, 2002 at 02:06:05 +0100
X-Mailer: Balsa 2.0.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2002.12.26 Andrea Arcangeli wrote:
[...]
> 
> Only in 2.4.21pre2aa1: 9990_hack-drop-x86-fast-pte-2
> 
[...]
> 	I never noticed this problem before because I rarely use 3d (and usually
> 	I had mesasoft setup anyways). It's not specific to a certain graphics card,
> 	so it looks more like an agp generic problem or something, I can
> 	reproduce myself on my laptop i830 graphics card and i830 agp, on my
> 	desktop g450 with amd agp, and on my test box on a ati radeon 7500 and
> 	intel agp, so it doesn't look like a lowlevel driver problem, and it
> 	only hurts while using the agp and/or drm somehow. Many thanks to
> 	Srihari Vijayaraghavan who found the offending patch in the whole kit
> 	originally some time ago.
> 

I saw it also using nVidia drivers, that do not touch drm. So I would vote for
agpgart.

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.1 (Cooker) for i586
Linux 2.4.21-pre2-jam1 (gcc 3.2.1 (Mandrake Linux 9.1 3.2.1-2mdk))
