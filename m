Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267265AbSLKS66>; Wed, 11 Dec 2002 13:58:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267270AbSLKS66>; Wed, 11 Dec 2002 13:58:58 -0500
Received: from pc2-cwma1-4-cust129.swan.cable.ntl.com ([213.105.254.129]:36291
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267265AbSLKS65>; Wed, 11 Dec 2002 13:58:57 -0500
Subject: Re: [2.4]ALi M5451 sound hangs on init; workaround
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Fedor Karpelevitch <fedor@apache.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Vicente Aguilar <bisente@bisente.com>,
       alsa-devel@lists.sourceforge.net,
       Debian-Laptops <debian-laptop@lists.debian.org>
In-Reply-To: <200212111036.21771.fedor@apache.org>
References: <200212110715.20617.fedor@apache.org>
	<1039625298.18087.61.camel@irongate.swansea.linux.org.uk>
	<200212110852.42778.fedor@apache.org>  <200212111036.21771.fedor@apache.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 11 Dec 2002 19:39:48 +0000
Message-Id: <1039635588.18587.8.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-12-11 at 18:36, Fedor Karpelevitch wrote:
> almost as I posted before, just passing pointers to the read method.
> It works, but the question as to what is this supposed to affect 
> remains...

If I am reading the docs right then its just a thinko in the code and it
is meant to be toggling that bit not whacking the entire register.


