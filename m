Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318389AbSHELl4>; Mon, 5 Aug 2002 07:41:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318390AbSHELl4>; Mon, 5 Aug 2002 07:41:56 -0400
Received: from mail-fe71.tele2.ee ([212.107.32.235]:20376 "HELO everyday.com")
	by vger.kernel.org with SMTP id <S318389AbSHELlz> convert rfc822-to-8bit;
	Mon, 5 Aug 2002 07:41:55 -0400
Date: Mon, 5 Aug 2002 13:45:27 +0200
Message-Id: <200208051145.g75BjRN30389@eday-fe5.tele2.ee>
From: "Thomas Munck Steenholdt" <tmus@get2net.dk>
Cc: linux-kernel@vger.kernel.org
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Subject: Sv: i810 sound broken...
MIME-Version: 1.0
X-EdMessageId: 5408581e5a5855190e4b545346615c404714594b105544554a4951504a1a565d5a91
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Mon, 2002-08-05 at 12:27, Thomas Munck Steenholdt wrote:
> > I've noticed some writing on lkml on how i810(AC97) sound was broken.
> > Aparantly a couple of fixes have been posted, but I couldn't see
> > where(if at all) those patches have gone... 2.4.19 still does not work
> > and 2.4.19-ac3 won't even load the i810 module.
> >
> > Does anybody know if the known i810 sound issue has, in fact, been
> fixed,
> and if so - in what kernel/patch?
> 
> Its working nicely for me in 2.4.19 and 2.4.19-ac1. The 2.4.19-ac3 tree
> has a bug in pci_enable_device which will stop it working if built with
> some compilers (by chance it works ok the way I tested it). Thats fixed
> in ac4.
> 
> The changes in the recent i810 audio are
> - Being more pessimistic in our interpretation of codec power up
> - Turning on EAPD in case the BIOS didn't do so at boot up
> 
> Longer term full EAPD control as we do with the cs46xx is on my list,
> paticularly as i8xx laptops are becoming common . (EAPD is the amplifier
> power controller)

That's strange - I get the same scratchy sounds on 2.4.19 as I did on 2.4.18 and a couple of the 2.4.19-pre's... Is there anything I should try, to make sure things are configged / built correctly..?


-- Send gratis SMS og brug gratis e-mail på Everyday.com -- 

