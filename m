Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317012AbSFAMxc>; Sat, 1 Jun 2002 08:53:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317013AbSFAMxb>; Sat, 1 Jun 2002 08:53:31 -0400
Received: from mta11n.bluewin.ch ([195.186.1.211]:11609 "EHLO
	mta11n.bluewin.ch") by vger.kernel.org with ESMTP
	id <S317012AbSFAMxb>; Sat, 1 Jun 2002 08:53:31 -0400
Date: Sat, 1 Jun 2002 14:52:39 +0200
From: Roger Luethi <rl@hellgate.ch>
To: Urban Widmark <urban@teststation.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix VIA Rhine time outs (some)
Message-ID: <20020601125238.GA7055@k3.hellgate.ch>
In-Reply-To: <20020601105745.GA2726@k3.hellgate.ch> <Pine.LNX.4.44.0206011335300.15719-100000@cola.enlightnet.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-Operating-System: Linux 2.4.8-ac9 on i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 01 Jun 2002 13:55:42 +0200, Urban Widmark wrote:
> You shouldn't use virt_to_bus().

Drats. Of course you're right. Ivan G. told me that, too. Can we agree that
this is a experimental patch (that's why I didn't cc Jeff) and that we
don't care? ;-) For my development version I broke out the whole restart
stuff into a separate inline function which comes with plenty of space to
hide away pointer arithmetics, and that's where I'm basically doing what
you suggest.  Currently I am just trying to a) find out how effective the
smallest fix I could possibly come up with is, and b) save time since I'm
kinda busy right now. Feel free to rewrite the patch to make DMA-mapping.txt
happy, though <g>.

Roger
