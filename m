Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261246AbTCXXvo>; Mon, 24 Mar 2003 18:51:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261258AbTCXXvo>; Mon, 24 Mar 2003 18:51:44 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:43184
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261246AbTCXXvm>; Mon, 24 Mar 2003 18:51:42 -0500
Subject: Re: Via8233 Onboard Sound Card (RE: [PATCH 2.4.20] Via 8233 Sound
	Support)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Adam Luter <luterac@bellsouth.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030324213953.GC508@smeagol.midgard>
References: <20030324213953.GC508@smeagol.midgard>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1048554955.26956.4.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 25 Mar 2003 01:15:56 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-03-24 at 21:39, Adam Luter wrote:
> Unfortunately I don't know what details to report!  Just that it
> didn't work and I get this error message (which, looking at the source
> means some sort of write error to the card, er, chip):
> 
> via_audio: ignoring drain playback error -512

Thats a misleading non error path. The one problem it has right nwo is
that it fails to work with gnome's esd audio subsystem but works with
everything else. I don't know why and I'm not yet motivated to fix it
since my views on esd are mostly unprintable.


