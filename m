Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286282AbRLTQJ6>; Thu, 20 Dec 2001 11:09:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286283AbRLTQJs>; Thu, 20 Dec 2001 11:09:48 -0500
Received: from [151.17.201.167] ([151.17.201.167]:52488 "EHLO mail.teamfab.it")
	by vger.kernel.org with ESMTP id <S286282AbRLTQJf>;
	Thu, 20 Dec 2001 11:09:35 -0500
Message-ID: <3C220C45.FD0D1CB2@teamfab.it>
Date: Thu, 20 Dec 2001 17:05:25 +0100
From: Luca Montecchiani <luca.montecchiani@teamfab.it>
Reply-To: m.luca@iname.com
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.19-i586-SMP-modular i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Vojtech Pavlik <vojtech@suse.cz>
CC: Luca Montecchiani <m.luca@iname.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@redhat.com>
Subject: Re: [PATCH] Trident 4DWave DX/NX joystick support
In-Reply-To: <3C21229F.A6864423@iname.com> <20011220153855.C30746@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik wrote:

> I must say I don't like the patch much. 

There are couples of other pci cards that do the same
and right now is the only way to make joystick works with
trident sound card.
I hope to help some users around here.

> If there is anything going to be added to trident.c 
> in regards to enabling the joystick, I think most of
> the pcigame.c code should be moved in there.

Not necessary, 2.2.19 joy-pci code works fine, no conflict
no oops, what about comparing against 2.4.x pcigame ?

Unfortunately I don't know how do that, but I can help you
testing patch, etc...

I hope to provide you the oops I've got insmodding analog
tomorrow.

> That way, there won't be
> resource conflicts and we won't lose any functionality.

I don't understand where the problem came from, with
2.2.19 everything work fine, I can use the joy-pci with
the trident module up and running, with the 2.4.17rc2
trident and pcigame are mutually exclusive.
Because of the 2.4.x pci changes ? Let's see.

ciao,
luca
