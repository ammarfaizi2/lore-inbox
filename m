Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261291AbVALIYr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261291AbVALIYr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 03:24:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261289AbVALIYq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 03:24:46 -0500
Received: from bernache.ens-lyon.fr ([140.77.167.10]:48034 "EHLO
	bernache.ens-lyon.fr") by vger.kernel.org with ESMTP
	id S261287AbVALIYi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 03:24:38 -0500
Message-ID: <41E4DEBB.90606@ens-lyon.fr>
Date: Wed, 12 Jan 2005 09:24:27 +0100
From: Brice Goglin <Brice.Goglin@ens-lyon.fr>
Reply-To: Brice.Goglin@ens-lyon.org
User-Agent: Mozilla Thunderbird 0.9 (X11/20041124)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.11-rc1
References: <Pine.LNX.4.58.0501112100250.2373@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0501112100250.2373@ppc970.osdl.org>
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Report: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds a écrit :
> Ok, the big merges after 2.6.10 are hopefully over, and 2.6.11-rc1 is out 
> there.
> 
> Lots of small cleanups, although that inevitable qlogic firmware update 
> makes pretty much _everything_ look small in comparison. 
> 
> SCSI, USB, IDE, x86-64, FRV, PPC64, ARM, input layer, ALSA, network
> drivers, pcmcia, knfsd, ACPI, sparse cleanups... You name it. Lots of
> (mostly) small updates all over the landscape.

Hi Linus,

setkeycodes does not work anymore on my Compaq Evo N600c running a Debian testing.

puligny:~# setkeycodes e023 150 e01e 155 e01a 217 e01f 157
KDSETKEYCODE: No such device
failed to set scancode a3 to keycode 150

Of course, the old warnings are back when I pressed one of the multimedia keys :

atkbd.c: Unknown key pressed (translated set 2, code 0xa3 on isa0060/serio0).
atkbd.c: Use 'setkeycodes e023 <keycode>' to make it known.

Am I supposed to do something to get it back on 2.6.11-rc1 ?

Regards
Brice
