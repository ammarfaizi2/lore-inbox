Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265908AbSKDHHA>; Mon, 4 Nov 2002 02:07:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265914AbSKDHHA>; Mon, 4 Nov 2002 02:07:00 -0500
Received: from pimout4-ext.prodigy.net ([207.115.63.103]:50363 "EHLO
	pimout4-ext.prodigy.net") by vger.kernel.org with ESMTP
	id <S265908AbSKDHG7> convert rfc822-to-8bit; Mon, 4 Nov 2002 02:06:59 -0500
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
Reply-To: landley@trommello.org
To: Steven Dake <sdake@mvista.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] SCSI and FibreChannel Hotswap for linux 2.5.44-bk2
Date: Mon, 4 Nov 2002 02:13:29 +0000
User-Agent: KMail/1.4.3
References: <3DC02AF7.6020209@mvista.com>
In-Reply-To: <3DC02AF7.6020209@mvista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200211011953.40118.landley@trommello.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 30 October 2002 18:54, Steven Dake wrote:

> This patch has been reviewed by Alan Cox, Greg KH, Christoph Hellwig,
> Patrick Mansfield, Rob Landly, Jeff Garzik, Scott Murray, James

I haven't got a single system around here with SCSI hardware in it anymore, 
and the last time I dealt with fibrechannel was almost two years ago now.  I 
just tracked the patch for other people who would be interested.

Rob

P.S.  Personally, I think SCSI is kind of pointless these days.  I fit 20 IDE 
drives in a box once, configured as raid 5.  These days that would be over 3 
terabytes.  Yes, the cables were annoying.  And if you need more space than 
that just use a clustering filesystem over gigabit eithernet.  Or for that 
matter, 100baseT with gigabit uplinks on the switches is usually plenty.  
(The cost of gigabit has come down, but the switches are murder.  That's why 
bonding pairs of 100baseT cards isn't necessarily cost effective: the cards 
themselves are dirt cheap but switches with gigabit uplinks more than make up 
the difference, as we wait for 10gigE to bring the cost of normal 1gigE down 
to something reasonable...)

Then again I've always been trying to optimize the price to performance ratio 
more than anything else.  I'm a cheap bastard and proud of it...

-- 
http://penguicon.sf.net - Terry Pratchett, Eric Raymond, Pete Abrams, Illiad, 
CmdrTaco, liquid nitrogen ice cream, and caffienated jello.  Well why not?



