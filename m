Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261955AbSJAP77>; Tue, 1 Oct 2002 11:59:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261698AbSJAP76>; Tue, 1 Oct 2002 11:59:58 -0400
Received: from mailout02.sul.t-online.com ([194.25.134.17]:5851 "EHLO
	mailout02.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S262128AbSJAP7x>; Tue, 1 Oct 2002 11:59:53 -0400
X-Face: >Q)4Pn.JVfRz{G(G_eIkykbZGG\)2mk8:5a"{^Mk07iC#F.t2L7h<Sa|7Zr1_L8[nbiq:8F
 %o\(7>|]{*cFg$GEPDdun~+UTjG(^4z<_Ksw%L-\w0xDmUR~<zsnGH]&sK=M\Y=;U4XZ"z)[CX6I6d
 _p
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Jochen Friedrich <jochen@scram.de>,
       Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.3.39 LLC on Alpha broken?
References: <Pine.LNX.4.44.0209301000260.1068-100000@alpha.bocc.de>
	<Pine.SGI.4.44.0209302302160.1085-100000@seray.bocc.de>
	<20021001184627.B3726@jurassic.park.msu.ru>
From: Falk Hueffner <falk.hueffner@student.uni-tuebingen.de>
Date: 01 Oct 2002 18:05:15 +0200
In-Reply-To: <20021001184627.B3726@jurassic.park.msu.ru>
Message-ID: <87heg6ta9w.fsf@student.uni-tuebingen.de>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.5 (broccoli)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ivan Kokshaysky <ink@jurassic.park.msu.ru> writes:

> On Mon, Sep 30, 2002 at 11:04:17PM +0200, Jochen Friedrich wrote:
> >  - After shutting down the Alpha with a "reboot" command, the last message
> > on the console was "Rebooting...". After that... nothing. Not even a
> > power-off - power-on helped, anymore. I just get 4 beeps from my Alpha
> > now, indicating an invalid firmware checksum... So 2.5.39 seems to be an
> > alpha2brick release :-(
> 
> Strange. It works fine for me on sx164 and nautilus.  I could guess
> either a) some driver bug that accidentally hit the flash-ROM area
> or b) just a terrible coincidence.

Hmm, shutting down didn't work on my Nautilus with 2.5.39+Ivan's
Nautilus patches, either. It did not nuke the firmware, though...

-- 
	Falk
