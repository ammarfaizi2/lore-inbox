Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262129AbTJASba (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 14:31:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262126AbTJASa1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 14:30:27 -0400
Received: from [62.67.222.139] ([62.67.222.139]:26013 "EHLO mail.ku-gbr.de")
	by vger.kernel.org with ESMTP id S262348AbTJASaL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 14:30:11 -0400
Date: Wed, 1 Oct 2003 20:28:59 +0200
From: Konstantin Kletschke <konsti@ludenkalle.de>
To: linux-kernel@vger.kernel.org
Subject: Date/UnixTime of SysRq state dump
Message-ID: <20031001182859.GA4081%konsti@ludenkalle.de>
Reply-To: Konstantin Kletschke <konsti@ludenkalle.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Kletschke & Uhlig GbR
User-Agent: Mutt/1.5.4i-ja.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there!

I know my machine as a rockstable P4 Computer, since
linux-2.6.0-test5-mm4 it freezes once a day. Not here and then, it
happened after long usage from 17:00 or 18:00 around midnight two times
yesterday and before yesterday. Don't laugh, is it possible that a day
change triggers a bug which freezes system? The second time I looked at
my screens at realized, that I saw this picture the day before: Irssi's
last message was "Day changed to ...". I was in heavy chatting, there
was no message even a second after that. Reading that I would laugh, but
it happened two times...

linux-2.6.0-test5-mm3 and older never freezed.

I have the state dump, catched via serial line at
http://ludenkalle.de/capture-2003-09-30-linux-2.6.0-test5-mm4.log
for who is interested, but the Kernel ist tainted by the nvidia module
:(
But this time it is different. Normally, ehen this module is involved,
sound hangs, but keeps on playing in a half a second long loop.

This times all was silent...

Well, if the tainting is not acceptable tell me even if an clock/time
bug in kernel on day change could cause a complete system freeze :)

Konsti




-- 
2.6.0-test6-mm1
Konstantin Kletschke <konsti@ludenkalle.de>, <konsti@ku-gbr.de>
GPG KeyID EF62FCEF
Fingerprint: 13C9 B16B 9844 EC15 CC2E  A080 1E69 3FDA EF62 FCEF
keulator.homelinux.org up 1:16, 14 users
