Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269115AbTCBDp3>; Sat, 1 Mar 2003 22:45:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269117AbTCBDp3>; Sat, 1 Mar 2003 22:45:29 -0500
Received: from virtisp1.zianet.com ([216.234.192.105]:11785 "HELO
	mesatop.zianet.com") by vger.kernel.org with SMTP
	id <S269115AbTCBDp2>; Sat, 1 Mar 2003 22:45:28 -0500
Subject: Re: [PATCH] kernel source spellchecker
From: Steven Cole <elenstev@mesatop.com>
To: Dan Kegel <dank@kegel.com>
Cc: Matthias Schniedermeyer <ms@citd.de>, Joe Perches <joe@perches.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, mike@aiinc.ca
In-Reply-To: <3E617428.3090207@kegel.com>
References: <Pine.LNX.4.44.0303011503590.29947-101000@korben.citd.de>
	<3E6101DE.5060301@kegel.com> <1046546305.10138.415.camel@spc1.mesatop.com>
	<3E6167B1.6040206@kegel.com>  <3E617428.3090207@kegel.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 01 Mar 2003 20:54:36 -0700
Message-Id: <1046577278.2543.445.camel@spc1.mesatop.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-03-01 at 20:02, Dan Kegel wrote:
> My corrections file is up at http://www.kegel.com/spell-fix-dan1.txt
[snip]
> 
> Any other changes people want to see in the script
> or the corrections file?   Should I add fixes for
> uncommon errors (those that happen only in one or two files)?

Correction:
transmitting=transmiting
triggered=tiggered,triggerred
trigging=triggerg
^^^^^^^^
This should be "triggering" here (I hope).

[steven@spc5 linux]$ find . -type f | xargs grep triggerg
./sound/isa/sb/emu8000_callback.c:         for triggerg the voice */
./sound/isa/sb/emu8000_pcm.c:      for triggerg the voice */
./sound/pci/emu10k1/emu10k1_callback.c:    for triggerg the voice */

Steven

