Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273083AbRIOVdb>; Sat, 15 Sep 2001 17:33:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273076AbRIOVdV>; Sat, 15 Sep 2001 17:33:21 -0400
Received: from fe090.worldonline.dk ([212.54.64.152]:8204 "HELO
	fe090.worldonline.dk") by vger.kernel.org with SMTP
	id <S273083AbRIOVdK>; Sat, 15 Sep 2001 17:33:10 -0400
Message-ID: <3BA245D1.B794D285@eisenstein.dk>
Date: Fri, 14 Sep 2001 20:00:49 +0200
From: Jesper Juhl <juhl@eisenstein.dk>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.10-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Robert Love <rml@tech9.net>, torvalds@transmeta.com,
        laughing@shared-source.org
Subject: Re: [PATCH] (Updated) AMD 761 AGP GART Support
In-Reply-To: <1000587574.32707.80.camel@phantasy>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love wrote:

> Linus,
>
> the following patch adds signature for the AMD 761 to the AGP GART
> code.  It has been tested and works.  Please, apply.

This is just to confirm that the final patch send out by Robert works fine. I have tested the
patch against 2.4.10-pre9 and it applies, builds and works properly. I can see no ill effects of
this patch, it correctly identifies my AMD 761 chipset and everything works perfectly.

Below are the relevant parts of dmesg output from my box to show that everything is fine:

...
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 439M
agpgart: Detected AMD 761 chipset
agpgart: AGP aperture is 64M @ 0xf8000000
...
NVRM: loading NVIDIA kernel module version 1.0-1251
NVRM: not using NVAGP, AGPGART is loaded!!


Best regards,
Jesper Juhl
juhl@eisenstein.dk


PS. I have also tested the patch that Robert send out to correct the config name, and I can
confirm that that one also works as expected.


