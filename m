Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317782AbSFSGMo>; Wed, 19 Jun 2002 02:12:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317784AbSFSGMn>; Wed, 19 Jun 2002 02:12:43 -0400
Received: from cm.denali.net ([24.237.4.20]:60045 "HELO hedwig.denali.net")
	by vger.kernel.org with SMTP id <S317782AbSFSGMm>;
	Wed, 19 Jun 2002 02:12:42 -0400
To: <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.22 ide disk hang on boot
From: <leif@denali.net>
Cc: <dalecki@evision-ventures.com>, <arnd@bergmann-dalldorf.de>
Date: Tue, 18 Jun 2002 22:12:43 AKDT
Reply-To: <leif@denali.net>
X-Priority: 3 (Normal)
X-Originating-Ip: [192.168.1.3]
X-Mailer: NOCC v0.9.5
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: 8bit
Message-Id: <20020619061243.2698F3C8B4@hedwig.denali.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm having exactly the same issue, with both 2.5.22 and 2.5.23.

I've downloaded the ide-clean-92.diff and applied it against 2.5.23.  There were some fuzzy offsets, but no rejects.

My system is:  FIC SD-11, Athlon 850, 256Mb ram, 20G Maxtor 52049U4 drive (80-pin cable)

IDE controler is VT82c686a UDMA66 (onboard)

The kernel is built SMP, but running UP for testing.

After rebuilding the kernel and rebooting, I'm able to get past the point where it was previously hanging.

Without this patch it hangs, just as Arnd reported.

Thanks.



___________________________________
NOCC, http://nocc.sourceforge.net




