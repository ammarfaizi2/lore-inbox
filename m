Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265096AbTA1Nif>; Tue, 28 Jan 2003 08:38:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265306AbTA1Nif>; Tue, 28 Jan 2003 08:38:35 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:45952
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id <S265096AbTA1Nid>; Tue, 28 Jan 2003 08:38:33 -0500
Subject: Re: Bootscreen
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Wichert Akkerman <wichert@wiggy.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030128130953.GW4868@wiggy.net>
References: <Pine.LNX.4.44.0301281113480.20283-100000@schubert.rdns.com>
	 <200301281144.h0SBi0ld000233@darkstar.example.net>
	 <20030128114840.GV4868@wiggy.net>
	 <1043758528.8100.35.camel@dhcp22.swansea.linux.org.uk>
	 <20030128130953.GW4868@wiggy.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1043761632.1316.67.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 28 Jan 2003 13:47:13 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-01-28 at 13:09, Wichert Akkerman wrote:
> It takes a while before the kernel starts init though, especially if you
> have things like SCSI controllers to initialise. If you do not use fb
> you can have your bootloader setup a pretty bootscreen, but if you need
> fb I don't see how you can prevent the textscreen with kernel messages.

I'd not really pondered people who compile many drivers into their kernel
instead of into the initrd. I guess a few people still do that.

As to the messages, if you are in graphical mode then you are right, the
messages could be supressed and sent via user space but not directly. I
guess the other way then is to use a custom font, set the configuration to
not leave gaps between characters and draw a boot graphical view in that
font ?

