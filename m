Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130569AbQKOWIt>; Wed, 15 Nov 2000 17:08:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130453AbQKOWIj>; Wed, 15 Nov 2000 17:08:39 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:50701 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S130606AbQKOWIa>; Wed, 15 Nov 2000 17:08:30 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: New bluesmoke patch available, implements MCE-without-MCA support
Date: 15 Nov 2000 13:37:56 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <8uuvnk$1v8$1@cesium.transmeta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2000 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

I have just released a second bluesmoke patch:

ftp://ftp.kernel.org/pub/linux/kernel/people/hpa/bluesmoke-2.4.0-test11-pre5-2.diff

This implements support for MCE on chips which don't support MCA (in
addition to enabling MCA for non-Intel chips, like Athlon, which
supports MCA.)

I would appreciate it if people who have chips with MCE but no MCA --
this includes older AMD chips and some Cyrix chips at the very least
-- would please be so kind and try this out.

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
