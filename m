Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265760AbUFSOGO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265760AbUFSOGO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jun 2004 10:06:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265764AbUFSOGO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jun 2004 10:06:14 -0400
Received: from postfix3-2.free.fr ([213.228.0.169]:15316 "EHLO
	postfix3-2.free.fr") by vger.kernel.org with ESMTP id S265760AbUFSOGJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jun 2004 10:06:09 -0400
From: Duncan Sands <baldrick@free.fr>
To: FlashCode <flashcode@flashtux.org>
Subject: Re: USB problems with 2.6.7 kernel / EciAdsl driver
Date: Sat, 19 Jun 2004 16:06:08 +0200
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org
References: <20040619101934.GA1938@photon>
In-Reply-To: <20040619101934.GA1938@photon>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200406191606.08919.baldrick@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm part of EciAdsl USB ADSL modem driver developers
> (http://eciadsl.flashtux.org)
> I installed 2.6.7 kernel and I have some problems:
> since I upload anything at max speed (15 kb/sec for me), I'm
> disconnected after 2-5 sec with this USB error in /var/log/messages:
> Jun 19 11:13:18 photon kernel: usb 1-2: bulk timeout on ep2out
> Jun 19 11:13:18 photon kernel: usb 1-2: usbfs: USBDEVFS_BULK failed ep
> 0x2 len 1984 ret -110
> No problem when I download sth.
> 
> I've tested with 2 machines (same problem), with these USB chipsets:
> machine 1:
> 0000:00:07.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB
> 1.1 Controller (rev 10)
> machine 2:
> 0000:00:1d.0 USB Controller: Intel Corp. 82801DB (ICH4) USB UHCI #1 (rev
> 03)
> 
> I tested with noapic option, same usb crash.

Is it a crash?

> Many other people have same problem, maybe not for each upload, but lot
> of disconnections with same error in logs..
> 
> Finally, I have no problem with 2.6.6 kernel or any older kernel (2.6 or
> 2.4): connection is very stable.
> 
> Feel free to ask me more for testing.
> Thanks for any help.
> 
> I've not subscribed to LKML, so please CC me for any answer.

I think you should send a copy of your message to the USB mailing list
(see linux-usb.sf.net).

Ciao,

Duncan.
