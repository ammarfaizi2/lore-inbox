Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274146AbRIXSrX>; Mon, 24 Sep 2001 14:47:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274141AbRIXSrN>; Mon, 24 Sep 2001 14:47:13 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:62052 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S274146AbRIXSrB>; Mon, 24 Sep 2001 14:47:01 -0400
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: David Grant <davidgrant79@hotmail.com>, Greg Ward <gward@python.net>,
        bugs@linux-ide.org, linux-kernel@vger.kernel.org
Subject: Re: "hde: timeout waiting for DMA": message gone, same behaviour
In-Reply-To: <20010921134402.A975@gerg.ca> <20010921205356.A1104@suse.cz>
	<20010921150806.A2453@gerg.ca> <20010921154903.A621@gerg.ca>
	<20010921215622.A1282@suse.cz> <20010921164304.A545@gerg.ca>
	<20010922100451.A2229@suse.cz>
	<OE3183UV8wAddX47sFo00001649@hotmail.com>
	<20010922110945.B678@gerg.ca>
	<OE48GTjkifTNRMOKS310000192c@hotmail.com>
	<20010924103544.A1572@suse.cz>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 24 Sep 2001 12:37:32 -0600
In-Reply-To: <20010924103544.A1572@suse.cz>
Message-ID: <m1k7yo77v7.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik <vojtech@suse.cz> writes:

> The PnP stuff is for ISA PnP cards. If you don't have those, it's
> irrelevant. When "PnP OS Installed" is set to "No", the BIOS does the
> ISAPnP initialization. If it is set to "Yes", it skips that step. Linux
> prefers to have the ISAPnP cards pre-initialized, though it can do it
> all by itself.

"PnP OS Installed" applies to PCI as well as ISA PnP.  The rule is
something like all possible boot devices must be initialized but that
is all. 

Eric
