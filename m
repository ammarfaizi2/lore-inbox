Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129608AbRCCRH5>; Sat, 3 Mar 2001 12:07:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129609AbRCCRHs>; Sat, 3 Mar 2001 12:07:48 -0500
Received: from 513.holly-springs.nc.us ([216.27.31.173]:41437 "EHLO
	513.holly-springs.nc.us") by vger.kernel.org with ESMTP
	id <S129608AbRCCRHp>; Sat, 3 Mar 2001 12:07:45 -0500
Message-Id: <200103031758.f23HwMQ22642@513.holly-springs.nc.us>
Subject: Re: VT82C586B USB PCI card, Linux USB
From: Michael Rothwell <rothwell@holly-springs.nc.us>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010303125436.A803@suse.cz>
In-Reply-To: <200103030503.f2353PQ21936@513.holly-springs.nc.us> 
	<20010303125436.A803@suse.cz>
Content-Type: text/plain
X-Mailer: Evolution (0.8/+cvs.2001.02.14.08.55 - Preview Release)
Date: 03 Mar 2001 13:08:48 -0500
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 03 Mar 2001 12:54:36 +0100, Vojtech Pavlik wrote:
> No, they have a separate USB chip, but it has the same PCI ID as the
> builtin silicon in the southbridge.


Ah. I went and looked up that chip ID at via's website, and saw only
southbridge chips, no USB-only chips at all. But, my real question was,
is there a way to get it to work right under Linux? I have two machines;
one is an Athlon with built-in (Via) USB support, and it seems to work
ok. I also have a P-200 that's my print server, file server and
(hopefully) scanner server. It is an old HX-chipset pre-USB socket-7
intel machine, but I've put a Via-chipset 2-port USB card into it. I
keep getting timeouts on it. I've looked all over the net for clues as
to what I can do to get it to work, and nothing has. Both uhci and
usb-uhci have the same problems. Is there a generic cause for timeout
problems when doing bulk transfers?

