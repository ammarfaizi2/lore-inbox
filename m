Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318275AbSHUNWM>; Wed, 21 Aug 2002 09:22:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318283AbSHUNWL>; Wed, 21 Aug 2002 09:22:11 -0400
Received: from ns1.ionium.org ([62.27.22.2]:782 "HELO mail.ionium.org")
	by vger.kernel.org with SMTP id <S318275AbSHUNWL> convert rfc822-to-8bit;
	Wed, 21 Aug 2002 09:22:11 -0400
Content-Type: text/plain; charset=US-ASCII
From: Justin Heesemann <jh@ionium.org>
Organization: ionium Technologies
To: linux-kernel@vger.kernel.org
Subject: Re: shared graphic ram hangs kernel since 2.4.3-ac1
Date: Wed, 21 Aug 2002 15:29:56 +0200
User-Agent: KMail/1.4.2
References: <200208201527.51649.jh@ionium.org> <200208211352.29994.jh@ionium.org> <1029935812.26425.0.camel@irongate.swansea.linux.org.uk>
In-Reply-To: <1029935812.26425.0.camel@irongate.swansea.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200208211529.56917.jh@ionium.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 21 August 2002 15:16, Alan Cox wrote:
> On Wed, 2002-08-21 at 12:52, Justin Heesemann wrote:
> > 2.4.19-pre7 with pre6  arch/i386/kernel/setup.c   works !
> > as i dont have any highmem support configured and as i always have to
> > provide the option   mem=511M   (due to 1MB shared video ram) i suspect
> > that part of setup.c. but as i'm not a kernel hacker, any help would be
> > appreciated. note: any kernel prior to 2.4.3 was able to boot without the
> > mem=511M option.
>
> Are you running a very old version of grub ?

actually i am running lilo..
the one that comes with debian 3.0.
the problem also occurs with every bootable linux cd, that i tried.. as long 
as it's running kernel 2.4.19.
debian bf24 kernel image (i think its 2.4.16?) is booting when i append 
mem=511M, knoppix/gentoo with 2.4.19 doesnt.

would you suggest that i try grub ?

