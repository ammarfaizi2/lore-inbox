Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265380AbSK1Jzs>; Thu, 28 Nov 2002 04:55:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265373AbSK1Jzs>; Thu, 28 Nov 2002 04:55:48 -0500
Received: from angband.namesys.com ([212.16.7.85]:10884 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S265380AbSK1Jzs>; Thu, 28 Nov 2002 04:55:48 -0500
Date: Thu, 28 Nov 2002 13:03:08 +0300
From: Oleg Drokin <green@namesys.com>
To: "Henning P. Schmiedehausen" <hps@intermeta.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: reiserfs bug
Message-ID: <20021128130308.A11579@namesys.com>
References: <072801c296b8$2cb01000$6600a8c0@topconcepts.net> <20021128114755.A2724@namesys.com> <077201c296bb$43b4ac40$6600a8c0@topconcepts.net> <20021128115708.A2792@namesys.com> <as4mo7$ae8$1@forge.intermeta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <as4mo7$ae8$1@forge.intermeta.de>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Thu, Nov 28, 2002 at 09:13:43AM +0000, Henning P. Schmiedehausen wrote:
> >Sorry, but you seems to have faulty hardware (bad harddrive or something).
> >Reiserfs cannot tolerate bad blocks in journal area right now.
> >I'd suggest you to make a backup of your device and then to replace bad
> >harddrive.
> You still shouldn't panic the kernel in this case. IMHO.

Sure, panicking the kernel in case of a write error is not very nice thing to
do.
Jeff Mahoney (of SuSE) is working on improving this situation. He even
released a preview patch some time ago (on 7th May).

Bye,
    Oleg
