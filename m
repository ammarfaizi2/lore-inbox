Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267452AbTA3RNm>; Thu, 30 Jan 2003 12:13:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267491AbTA3RNm>; Thu, 30 Jan 2003 12:13:42 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:21896
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267452AbTA3RNl>; Thu, 30 Jan 2003 12:13:41 -0500
Subject: Re: Linux 2.4.21-pre4
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Thomas Davis <tadavis@lbl.gov>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <3E395C30.6040903@lbl.gov>
References: <Pine.LNX.4.53L.0301290143350.27119@freak.distro.conectiva>
	 <3E384D41.9080605@lbl.gov>
	 <1043926998.28133.21.camel@irongate.swansea.linux.org.uk>
	 <3E395C30.6040903@lbl.gov>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1043950661.31674.12.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 30 Jan 2003 18:17:41 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-01-30 at 17:09, Thomas Davis wrote:
> > FM801 is a card not a codec
> > 
> 
> Sorry, this then adds to the ac97 codec list the fm801, which has a ac97 
> codec on it, and takes it from being "unknown" to "known".
> 
> The forte driver uses the ac97codec code; with this, ac97_probe_codec 
> registers it correctly as Forte Media, and not unknown.

FM801 is still the card not the codec. Somewhere on the FM801 is a 48pin AC97 codec,
it may even vary by card version, much like I have intel i810 audio with a variety
of codec devices.

