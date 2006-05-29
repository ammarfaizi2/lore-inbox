Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750848AbWE2Ndk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750848AbWE2Ndk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 09:33:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750853AbWE2Ndk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 09:33:40 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:16572 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750840AbWE2Ndj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 09:33:39 -0400
Subject: Re: [v4l-dvb-maintainer] Re: Stradis driver conflicts with all
	other SAA7146 drivers
From: Mauro Carvalho Chehab <mchehab@infradead.org>
To: Michael Hunold <hunold@linuxtv.org>
Cc: Christer Weinigel <christer@weinigel.se>,
       v4l-dvb maintainer list <v4l-dvb-maintainer@linuxtv.org>,
       linux-kernel@vger.kernel.org, video4linux-list@redhat.com,
       Jiri Slaby <jirislaby@gmail.com>, Nathan Laredo <laredo@gnu.org>
In-Reply-To: <447AED3B.4070708@linuxtv.org>
References: <m3wtc6ib0v.fsf@zoo.weinigel.se> <44799D24.7050301@gmail.com>
	 <1148825088.1170.45.camel@praia>
	 <d6e463920605280901n41840baeuc30283a51e35204e@mail.gmail.com>
	 <1148837483.1170.65.camel@praia>  <m3k686hvzi.fsf@zoo.weinigel.se>
	 <1148841654.1170.70.camel@praia>  <447AED3B.4070708@linuxtv.org>
Content-Type: text/plain; charset=ISO-8859-1
Date: Mon, 29 May 2006 10:33:26 -0300
Message-Id: <1148909606.1170.94.camel@praia>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1-2mdk 
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Michael,

Em Seg, 2006-05-29 às 14:46 +0200, Michael Hunold escreveu:
> Hi,
> 
> on 28.05.2006 20:40 Mauro Carvalho Chehab said the following:
> > I don't have any saa7146 board, but, on bttv, most boards don't have its
> > own PCI ID.
> 
> As I said in the other mail, dpc7146, mxb and hexium_orion don't have
> subvendor/subdevice ids.
> 
> > It won't solve, however, the probing
> > intersection for dpc7146f, hexium_orion, mxb, and stradis when no
> > subvendor ID is specified on the board.
> 
> Probing is probably not possible for the devices mentioned above.
On bttv and other boards, were we have such conflicts, we have an option
to specify what board is used (called card). When the driver locates a
board without PCI subvendor ID, it shows a help msg at dmesg and exits
(or load a generic handler). The user may then use card=xx (where xx is
the number of the board). IMHO, this is the better for saa7146 boards.
> 
> > Cheers, 
> > Mauro.
> 
> CU
> Michael.
Cheers, 
Mauro.

