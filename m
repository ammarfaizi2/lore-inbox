Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291787AbSBXXKx>; Sun, 24 Feb 2002 18:10:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291829AbSBXXKo>; Sun, 24 Feb 2002 18:10:44 -0500
Received: from tapu.f00f.org ([66.60.186.129]:7810 "EHLO tapu.f00f.org")
	by vger.kernel.org with ESMTP id <S291826AbSBXXKe>;
	Sun, 24 Feb 2002 18:10:34 -0500
Date: Sun, 24 Feb 2002 15:10:19 -0800
From: Chris Wedgwood <cw@f00f.org>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Paul Mackerras <paulus@samba.org>, Troy Benjegerdes <hozer@drgw.net>,
        Martin Dalecki <dalecki@evision-ventures.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Andre Hedrick <andre@linuxdiskcert.org>,
        Rik van Riel <riel@conectiva.com.br>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Flash Back -- kernel 2.1.111
Message-ID: <20020224231019.GC15280@tapu.f00f.org>
In-Reply-To: <Pine.LNX.4.10.10202232136560.5715-100000@master.linux-ide.org> <Pine.LNX.4.33.0202232152200.26469-100000@home.transmeta.com> <20020224013038.G10251@altus.drgw.net> <3C78DA19.4020401@evision-ventures.com> <20020224142902.C1682@altus.drgw.net> <20020224215422.B1706@ucw.cz> <15481.25250.869765.860828@argo.ozlabs.ibm.com> <20020224231002.B2199@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020224231002.B2199@ucw.cz>
User-Agent: Mutt/1.3.27i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 24, 2002 at 11:10:02PM +0100, Vojtech Pavlik wrote:

    I really wonder why the 50 MHz one doesn't run at 66 MHz, and what
    happens if you plug in a 66MHz non-capable card to the 50 MHz bus.

The bus is supposed to go as fast as the slowest card --- no faster.
In this case I assume the bridge will drop the speed?  Paul?



  --cw
