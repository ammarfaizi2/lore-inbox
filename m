Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265095AbTA2Hio>; Wed, 29 Jan 2003 02:38:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265097AbTA2Hio>; Wed, 29 Jan 2003 02:38:44 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:30339
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S265095AbTA2Hin>; Wed, 29 Jan 2003 02:38:43 -0500
Subject: Re: nForce2 IDE UDMA locked to mode 2 on 2.4.21-pre4
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: John Wong <kernelATimplodeDOT!net@gambit.implode.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030129072658.GA790@gambit.implode.net>
References: <20030129072658.GA790@gambit.implode.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1043829731.27265.1.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 29 Jan 2003 08:42:11 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-01-29 at 07:26, John Wong wrote:
> With 2.4.21-pre4, the nForce2 chipset board I have has the IDE detected,
> but not quite properly.  It seems my UDMA 100 drives as only UDMA 33.
> When I use hdparm to try to change its mode, it fails with the following
> error.

I'm about to send Marcelo the replacement AMD driver that Vojtech wrote which does
both AMD and the nFarce clone of it. That I hope will make your problem obsolete

