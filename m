Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265247AbRGATUI>; Sun, 1 Jul 2001 15:20:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265239AbRGATT6>; Sun, 1 Jul 2001 15:19:58 -0400
Received: from [63.193.79.18] ([63.193.79.18]:24823 "HELO mwg.inxservices.lan")
	by vger.kernel.org with SMTP id <S265264AbRGATTl>;
	Sun, 1 Jul 2001 15:19:41 -0400
Date: Sun, 1 Jul 2001 12:19:05 -0700
From: George Garvey <tmwg-linuxknl@inxservices.com>
To: linux-kernel@vger.kernel.org
Subject: ASUS A7V/Thunderbird 1GHz lockup problems observation w/fix for me
Message-ID: <20010701121905.B9838@inxservices.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: inX Services, Los Angeles, CA, USA
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Ever since building this system there have been spontaneous and
unpredictable lockups, usually at least once per day. Sometimes several per
day. The lockup is sometimes preceded by X starting to display things
strangely (on a Voodoo 3 w/XF 4.X). Then I have a few minutes to reboot
before it hangs (can't log in using ssh from another system.)
   With the Northbridge discussion, I couldn't pinpoint anything to fix it,
so I started experimenting.
   Things got better by upgrading the BIOS; but still many hangs.
   I've discovered that changing the CPU voltage from the default to 1.75V
results in a stable system. Higher than that doesn't work. Lower still gets
lockups.
   It doesn't look like everyone has this problem with similar setups. But
if there are others, I wanted to share this discovery.
