Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267248AbTBLPbx>; Wed, 12 Feb 2003 10:31:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267252AbTBLPbw>; Wed, 12 Feb 2003 10:31:52 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:46464
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267248AbTBLPbV>; Wed, 12 Feb 2003 10:31:21 -0500
Subject: Re: via rhine bug? (timeouts and resets)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Christian Guggenberger 
	<Christian.Guggenberger@physik.uni-regensburg.de>
Cc: rl@hellgate.ch, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030212155836.A797@pc9391.uni-regensburg.de>
References: <20030212155836.A797@pc9391.uni-regensburg.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1045068074.2166.18.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 12 Feb 2003 16:41:15 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-02-12 at 14:58, Christian Guggenberger wrote:
> > o       Always set interrupt line with VIA northbridge  (me)
> >        | Should fix apic mode problems with USB/audio/net on VIA boards
> > 
> Can you please send a patch against 2.5.60, cause I would like to test these 
> IO APIC things on my via board. 2.4-ac is no choice for me, since patching xfs 
> into 2.4-ac is a little bit too painful for me;-)

At the moment I can't even get 2.5.60 to boot so its a bit hard to do any work
on it. Just run via boxes with "noapic" and dont enable the apic stuff on single
cpu systems. Thats as good if not a better test

