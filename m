Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132556AbRDKL14>; Wed, 11 Apr 2001 07:27:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132557AbRDKL1q>; Wed, 11 Apr 2001 07:27:46 -0400
Received: from danielle.hinet.hr ([195.29.254.157]:520 "EHLO danielle.hinet.hr")
	by vger.kernel.org with ESMTP id <S132556AbRDKL1d>;
	Wed, 11 Apr 2001 07:27:33 -0400
Date: Wed, 11 Apr 2001 13:27:34 +0200
From: Mario Mikocevic <mozgy@hinet.hr>
To: linux-kernel@vger.kernel.org
Subject: Few Qs regarding COMPAQ Proliant 6500
Message-ID: <20010411132734.B24141@danielle.hinet.hr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

 - on COMPAQ Proliant 6500 (P11) servers I have an embeded LCD,
   is there any kernel patch and/or user tools to use it ?

 - lately one of those servers hangs quite often

   I've changed hardware parts (mixing from other boxes) and concluded it's
   definately software, most probably kernel.
   It's a web and ftp server banged quite hard.

symptoms are complete hang without any suspicious trace in logs except one:

  just before that complete hang logs are filled with for example proftpd entries
  with exactly _same time_. I even managed once to stay logged in when hang is just about
  to happen -> date(1) kept showing some exactly the same time in the past whenever invoked
  but cat /proc/driver/rtc showed the proper time. The box refused any new connections.
  Few minutes later it hung.

Any pointers ? Patches to apply ?

I tried nmi_watchdog and noapic things, does not help.

-- 
Mario Mikoèeviæ (Mozgy)
My favourite FUBAR ...
