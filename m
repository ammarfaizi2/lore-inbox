Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262112AbREXPqr>; Thu, 24 May 2001 11:46:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262113AbREXPqg>; Thu, 24 May 2001 11:46:36 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:33028 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262112AbREXPqW>; Thu, 24 May 2001 11:46:22 -0400
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: Transmeta Crusoe support?
Date: 24 May 2001 08:46:14 -0700
Organization: A poorly-installed InterNetNews site
Message-ID: <9ejac6$8d4$1@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.33.0105241809180.1129-100000@boston.corp.fedex.com> <E152wAq-00053X-00@the-village.bc.nu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <E152wAq-00053X-00@the-village.bc.nu>,
Alan Cox  <alan@lxorguk.ukuu.org.uk> wrote:
>> Question is whether I need to recompile everything (kernel and binaries)
>> on my current 586 platform in order to move to Crusoe?
>
>No. Crusoe should work out of the box in that sense. Its actually however
>not brilliantly documented for things like longrun mode where folks have
>actually been poking around the acpi data in order to find out how the thing
>works... thats the ironic part 8)

Now, now, we released all the longrun utilities a few months ago, so the
"poke around ACPI" stuff is fairly dated by now (and what the reverse-
engineered code did was actually _not_ longrun at all, but "coolrun",
the temperature-based stuff). 

		Linus
