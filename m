Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265909AbSLNUpc>; Sat, 14 Dec 2002 15:45:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265936AbSLNUpc>; Sat, 14 Dec 2002 15:45:32 -0500
Received: from mailout05.sul.t-online.com ([194.25.134.82]:16844 "EHLO
	mailout05.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S265909AbSLNUpb>; Sat, 14 Dec 2002 15:45:31 -0500
Reply-to: Wolfgang Fritz <wolfgang.fritz@gmx.net>
To: linux-kernel@vger.kernel.org
From: Wolfgang Fritz <wolfgang.fritz@gmx.net>
Subject: Re: i4l dtmf errors
Date: Sat, 14 Dec 2002 21:51:10 +0100
Organization: None
Message-ID: <atg5jv$d73$1@fritz38552.news.dfncis.de>
References: <200212121145.26108.roy@karlsbakk.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
User-Agent: KNode/0.7.1
X-AntiVirus: checked by AntiVir MailGate (version: 2.0.1.7; AVE: 6.17.0.2; VDF: 6.17.0.5; host: gurke)
X-AntiVirus: checked by AntiVir MailGate (version: 2.0.1.7; AVE: 6.17.0.2; VDF: 6.17.0.5; host: gurke)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roy Sigurd Karlsbakk wrote:

> hi
> 
> it seems isdn4linux detects DTMF tones from normal speach. This is
> rather annoying when using i4l for voice with Asterisk.org. This is
> tested on all recent kernels

The DTMF detection is broken since kernel 2.0.x. I have a patch for a 
2.2 kernel which may manually be applied 2.4 kernels with some manual 
work. It fixes an overflow problem in the goertzel algorithm (which 
does the basic tone detection) and changes the algorithm to detect the 
DTMF pairs. If interested, I can try to recover that patch.

Wolfgang
  
> 
> see thread "[MGCP] Asterisk/D-Link phones generates ugly DTMF
> tones!!!" at http://www.marko.net/asterisk/archives/ for more info.
> 
> roy


