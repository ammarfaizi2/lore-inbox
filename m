Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278911AbRJ2A3u>; Sun, 28 Oct 2001 19:29:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278913AbRJ2A3k>; Sun, 28 Oct 2001 19:29:40 -0500
Received: from shed.alex.org.uk ([195.224.53.219]:9357 "HELO shed.alex.org.uk")
	by vger.kernel.org with SMTP id <S278911AbRJ2A3W>;
	Sun, 28 Oct 2001 19:29:22 -0500
Date: Mon, 29 Oct 2001 00:29:53 -0000
From: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Reply-To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
To: linux-kernel@vger.kernel.org
Cc: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Subject: IBM T-23 crashes on resume from suspend, 2.4.12-ac5
Message-ID: <34228322.1004315393@[195.224.237.69]>
X-Mailer: Mulberry/2.1.0 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When I suspend (apm -s, or system driven suspend), it appears to
work. When I resume, the screen comes back, but the system
appears to be dead to the extent that interrupts are disabled
(i.e. caps lock key has no effect, SysReq+anything does nothing).

Although I'm running X, I'm doing this bit from a normal virtual
console to make things simple.

I have tried various configuration options, including enabling
and disabling ACPI, Plug & Play, and setting APM to call the
BIOS with interrupts either enabled (seems to be recommended
for 'later IBM laptops' or disabled). And indeed disabling
APM support totally (I think I got it to work, once, using
this, but couldn't repeat it).

Any ideas?

.config file (one iteration thereof) can be found at:
  http://www.alex.org.uk/T23/dot-config-2.4.12-ac5

lspci output can be found at:
  http://www.alex.org.uk/T23/lspci.txt

--
Alex Bligh
