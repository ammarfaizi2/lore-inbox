Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129733AbRABATy>; Mon, 1 Jan 2001 19:19:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129593AbRABATo>; Mon, 1 Jan 2001 19:19:44 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:9481 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129733AbRABATh>; Mon, 1 Jan 2001 19:19:37 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: devices.txt inconsistency
Date: 1 Jan 2001 15:48:43 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <92r50r$5vq$1@cesium.transmeta.com>
In-Reply-To: <20010101170654.A5856@sourceware.net> <20010101232454.C8481@tenchi.datarithm.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20010101232454.C8481@tenchi.datarithm.net>
By author:    Robert Read <rread@datarithm.net>
In newsgroup: linux.dev.kernel
>
> devices.txt does need some updating. It still lists char-major-13 as
> the PC Speaker, but 13 appears to be the major for new input driver,
> and the joystick driver is now a minor off the that.  Are there now
> two Joystick drivers, or can char-major-15 be obsoleted/deleted?
> 

I think there are two; at least, the number will remain reserved for a
long time.

The current devices.txt is available at:

   http://www.lanana.org/docs/device-list/devices.txt

I don't have the details for /dev/input/* in there; I need to still
make that update.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
