Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261648AbSJAOlz>; Tue, 1 Oct 2002 10:41:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261646AbSJAOly>; Tue, 1 Oct 2002 10:41:54 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:2054 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S261648AbSJAOlw>; Tue, 1 Oct 2002 10:41:52 -0400
Date: Tue, 1 Oct 2002 18:46:27 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Jochen Friedrich <jochen@scram.de>
Cc: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.3.39 LLC on Alpha broken?
Message-ID: <20021001184627.B3726@jurassic.park.msu.ru>
References: <Pine.LNX.4.44.0209301000260.1068-100000@alpha.bocc.de> <Pine.SGI.4.44.0209302302160.1085-100000@seray.bocc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.SGI.4.44.0209302302160.1085-100000@seray.bocc.de>; from jochen@scram.de on Mon, Sep 30, 2002 at 11:04:17PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 30, 2002 at 11:04:17PM +0200, Jochen Friedrich wrote:
>  - After shutting down the Alpha with a "reboot" command, the last message
> on the console was "Rebooting...". After that... nothing. Not even a
> power-off - power-on helped, anymore. I just get 4 beeps from my Alpha
> now, indicating an invalid firmware checksum... So 2.5.39 seems to be an
> alpha2brick release :-(

Strange. It works fine for me on sx164 and nautilus.
I could guess either a) some driver bug that accidentally hit the flash-ROM
area or b) just a terrible coincidence.

I hope that your fail-safe booter is intact...

Ivan.
