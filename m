Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129583AbRBGDYq>; Tue, 6 Feb 2001 22:24:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129416AbRBGDYZ>; Tue, 6 Feb 2001 22:24:25 -0500
Received: from c1262263-a.grapid1.mi.home.com ([24.183.135.182]:6666 "EHLO
	mail.neruo.com") by vger.kernel.org with ESMTP id <S129119AbRBGDYV>;
	Tue, 6 Feb 2001 22:24:21 -0500
Subject: Re: Problems with Linux 2.4.1
From: Brad Douglas <brad@neruo.com>
To: Alexander Zvyagin <zvyagin@gamspc7.ihep.su>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.20.0102070207300.1226-500000@gamspc7.ihep.su>
Content-Type: text/plain
X-Mailer: Evolution 0.8 (Developer Preview)
Date: 06 Feb 2001 19:22:47 -0800
Mime-Version: 1.0
Message-Id: <20010207032424Z129119-513+3637@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 07 Feb 2001 02:27:57 +0000, Alexander Zvyagin wrote:

> 2) Frame-buffer mode does not work with my video card SiS630.
>    But ok, frame-buffer mode is EXPERIMENTAL in linux.
>    Computer boots, but screen is blank. All messages are fine.

> 01:00:0 VGA compatible controller: Silicon Integrated Systems [SiS]:
Unknown device 6300
> (rev 11)

Your particular chipset (actually, a 6300, which is different than the
630) is not supported by the SIS frame buffer.  If this chipset is a
VESA 2.0+ compatible controller, then you will be able to use the VESA
frame buffer.

Brad Douglas
brad@neuro.com
http://www.linux-fbdev.org


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
