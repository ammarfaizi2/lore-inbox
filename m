Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318714AbSIKKyt>; Wed, 11 Sep 2002 06:54:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318715AbSIKKys>; Wed, 11 Sep 2002 06:54:48 -0400
Received: from angband.namesys.com ([212.16.7.85]:1664 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S318714AbSIKKyr>; Wed, 11 Sep 2002 06:54:47 -0400
Date: Wed, 11 Sep 2002 14:59:29 +0400
From: Oleg Drokin <green@namesys.com>
To: Andi Kleen <ak@muc.de>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.20-pre6
Message-ID: <20020911145929.A4644@namesys.com>
References: <Pine.LNX.4.44.0209101501200.16518-100000@freak.distro.conectiva> <20020911140047.A924@namesys.com> <20020911121438.20537@colin.muc.de> <20020911143644.A841@namesys.com> <20020911125110.A9187@averell>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20020911125110.A9187@averell>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Wed, Sep 11, 2002 at 12:51:10PM +0200, Andi Kleen wrote:

> > > What other command line options do you use? Perhaps mem=nopentium? If yes
> > > does it help when you boot without that and with unsafe-gart-alias specified.
> > Yes, if I remove mem=nopentium , it boots ok.
> Ok. That makes it clearer.
> One final question: Did you compile your kernel with CONFIG_X86_PAE
> (= CONFIG_HIGHMEM64G) ? 

No.
green@angband:~/bk_work/reiser3-linux-2.4> grep CONFIG_HIGHMEM64G .config
# CONFIG_HIGHMEM64G is not set
green@angband:~/bk_work/reiser3-linux-2.4> grep CONFIG_HIGHMEM4G .config
CONFIG_HIGHMEM4G=y

Bye,
    Oleg
