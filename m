Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282827AbRK0HLw>; Tue, 27 Nov 2001 02:11:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282828AbRK0HLm>; Tue, 27 Nov 2001 02:11:42 -0500
Received: from kiruna.synopsys.com ([204.176.20.18]:35495 "HELO
	kiruna.synopsys.com") by vger.kernel.org with SMTP
	id <S282827AbRK0HLf>; Tue, 27 Nov 2001 02:11:35 -0500
From: "Alex Riesen" <riesen@synopsys.COM>
To: <linux-kernel@vger.kernel.org>
Subject: 2.4.16 alsa 0.5.12 mixer ioctl problem
Date: Tue, 27 Nov 2001 08:11:24 +0100
Message-ID: <HKEMJNBMMEMMAEHPEBGNCEBNCBAA.riesen@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, all

just tried to compile the mentioned alsa drivers under 2.4.16.
Mixer doesnt work, yes. It compiles, installs, loads. And
any program trying to open mixer (through libasound) get EINVAL.

All is compiled with gcc-2.95.3,
single CPU, with APIC (is any sense to enable it on
uniprocessors?).

Does anybody know what to do about it?

-alex
