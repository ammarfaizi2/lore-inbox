Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271112AbTG1VMZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 17:12:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271144AbTG1VMZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 17:12:25 -0400
Received: from luli.rootdir.de ([213.133.108.222]:55247 "HELO luli.rootdir.de")
	by vger.kernel.org with SMTP id S271112AbTG1VJR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 17:09:17 -0400
Date: Mon, 28 Jul 2003 23:09:10 +0200
From: Claas Langbehn <claas@rootdir.de>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: dean gaudet <dean-list-linux-kernel@arctic.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test2 has i8042 mux problems
Message-ID: <20030728210910.GA832@rootdir.de>
References: <20030728052614.GA5022@rootdir.de> <20030728113626.GA1706@win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030728113626.GA1706@win.tue.nl>
Reply-By: Don Jul 31 23:07:12 CEST 2003
X-Message-Flag: Cranky? Try Free Software instead!
X-Operating-System: Linux 2.6.0-test1-ac3 i686
X-No-archive: yes
X-Uptime: 23:07:12 up 1 min,  2 users,  load average: 0.87, 0.30, 0.10
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

its strange. After switching debug on, it suddenly works.
Below my debug info.

Regards, claas



>From syslog:
22:53:08 kernel: drivers/input/serio/i8042.c: 20 -> i8042 (command) [0]
22:53:08 kernel: drivers/input/serio/i8042.c: 67 <- i8042 (return) [0]
22:53:08 kernel: drivers/input/serio/i8042.c: 60 -> i8042 (command) [0]
22:53:08 kernel: drivers/input/serio/i8042.c: 76 -> i8042 (parameter) [0]
22:53:08 kernel: drivers/input/serio/i8042.c: d3 -> i8042 (command) [0]
22:53:08 kernel: drivers/input/serio/i8042.c: f0 -> i8042 (parameter) [0]
22:53:08 kernel: drivers/input/serio/i8042.c: 0f <- i8042 (return) [0]
22:53:08 kernel: drivers/input/serio/i8042.c: d3 -> i8042 (command) [0]
22:53:08 kernel: drivers/input/serio/i8042.c: 56 -> i8042 (parameter) [0]
22:53:08 kernel: drivers/input/serio/i8042.c: a9 <- i8042 (return) [0]
22:53:08 kernel: drivers/input/serio/i8042.c: d3 -> i8042 (command) [0]
22:53:08 kernel: drivers/input/serio/i8042.c: a4 -> i8042 (parameter) [0]
22:53:08 kernel: drivers/input/serio/i8042.c: 5b <- i8042 (return) [0]
22:53:08 kernel: drivers/input/serio/i8042.c: d3 -> i8042 (command) [0]
22:53:08 kernel: drivers/input/serio/i8042.c: 5a -> i8042 (parameter) [0]
22:53:08 kernel: drivers/input/serio/i8042.c: a5 <- i8042 (return) [0]
22:53:08 kernel: drivers/input/serio/i8042.c: a7 -> i8042 (command) [0]
22:53:08 kernel: drivers/input/serio/i8042.c: 20 -> i8042 (command) [0]
22:53:08 kernel: drivers/input/serio/i8042.c: 76 <- i8042 (return) [0]
22:53:08 kernel: drivers/input/serio/i8042.c: a8 -> i8042 (command) [0]
22:53:08 kernel: drivers/input/serio/i8042.c: 20 -> i8042 (command) [0]
22:53:08 kernel: drivers/input/serio/i8042.c: 56 <- i8042 (return) [0]
22:53:08 kernel: drivers/input/serio/i8042.c: 60 -> i8042 (command) [0]
22:53:08 kernel: drivers/input/serio/i8042.c: 74 -> i8042 (parameter) [0]
22:53:08 kernel: drivers/input/serio/i8042.c: 60 -> i8042 (command) [0]
22:53:08 kernel: drivers/input/serio/i8042.c: 54 -> i8042 (parameter) [0]
22:53:08 kernel: drivers/input/serio/i8042.c: 60 -> i8042 (command) [0]
22:53:08 kernel: drivers/input/serio/i8042.c: 56 -> i8042 (parameter) [0]
22:53:08 kernel: drivers/input/serio/i8042.c: d4 -> i8042 (command) [0]
22:53:08 kernel: drivers/input/serio/i8042.c: f2 -> i8042 (parameter) [0]
22:53:08 kernel: drivers/input/serio/i8042.c: d4 -> i8042 (command) [99]
22:53:08 kernel: drivers/input/serio/i8042.c: ed -> i8042 (parameter) [99]
22:53:08 kernel: drivers/input/serio/i8042.c: fe <- i8042 (interrupt, aux, 0, timeout) [99]
22:53:08 kernel: drivers/input/serio/i8042.c: 60 -> i8042 (command) [99]
22:53:08 kernel: drivers/input/serio/i8042.c: 54 -> i8042 (parameter) [99]
22:53:08 kernel: drivers/input/serio/i8042.c: fe <- i8042 (flush, kbd) [113]
22:53:08 kernel: drivers/input/serio/i8042.c: 60 -> i8042 (command) [113]
22:53:08 kernel: drivers/input/serio/i8042.c: 56 -> i8042 (parameter) [113]
22:53:08 kernel: drivers/input/serio/i8042.c: d4 -> i8042 (command) [113]
22:53:08 kernel: drivers/input/serio/i8042.c: f2 -> i8042 (parameter) [113]
22:53:08 kernel: drivers/input/serio/i8042.c: 60 -> i8042 (command) [212]
22:53:08 kernel: drivers/input/serio/i8042.c: 54 -> i8042 (parameter) [212]
22:53:08 kernel: drivers/input/serio/i8042.c: fe <- i8042 (flush, kbd) [212]
22:53:08 kernel: serio: i8042 AUX port at 0x60,0x64 irq 12
22:53:08 kernel: drivers/input/serio/i8042.c: 60 -> i8042 (command) [212]
22:53:08 kernel: drivers/input/serio/i8042.c: 44 -> i8042 (parameter) [212]
22:53:08 kernel: drivers/input/serio/i8042.c: 60 -> i8042 (command) [212]
22:53:08 kernel: drivers/input/serio/i8042.c: 45 -> i8042 (parameter) [212]
22:53:08 kernel: drivers/input/serio/i8042.c: f2 -> i8042 (kbd-data) [212]
22:53:08 kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, kbd, 1) [215]
22:53:08 kernel: drivers/input/serio/i8042.c: ab <- i8042 (interrupt, kbd, 1) [217]
22:53:08 kernel: drivers/input/serio/i8042.c: 41 <- i8042 (interrupt, kbd, 1) [218]
22:53:08 kernel: drivers/input/serio/i8042.c: ed -> i8042 (kbd-data) [218]
22:53:08 kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, kbd, 1) [221]
22:53:08 kernel: drivers/input/serio/i8042.c: 00 -> i8042 (kbd-data) [221]
22:53:08 kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, kbd, 1) [224]
22:53:08 kernel: drivers/input/serio/i8042.c: f8 -> i8042 (kbd-data) [224]
22:53:08 kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, kbd, 1) [227]
22:53:08 kernel: drivers/input/serio/i8042.c: f4 -> i8042 (kbd-data) [227]
22:53:08 kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, kbd, 1) [231]
22:53:08 kernel: drivers/input/serio/i8042.c: f0 -> i8042 (kbd-data) [231]
22:53:08 kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, kbd, 1) [234]
22:53:08 kernel: drivers/input/serio/i8042.c: 02 -> i8042 (kbd-data) [234]
22:53:08 kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, kbd, 1) [237]
22:53:08 kernel: drivers/input/serio/i8042.c: f0 -> i8042 (kbd-data) [237]
22:53:08 kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, kbd, 1) [240]
22:53:08 kernel: drivers/input/serio/i8042.c: 00 -> i8042 (kbd-data) [240]
22:53:08 kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, kbd, 1) [243]
22:53:08 kernel: drivers/input/serio/i8042.c: 41 <- i8042 (interrupt, kbd, 1) [244]
22:53:08 kernel: input: AT Set 2 keyboard on isa0060/serio0
22:53:08 kernel: serio: i8042 KBD port at 0x60,0x64 irq 1

>From dmesg:
drivers/input/serio/i8042.c: 20 -> i8042 (command) [0]
drivers/input/serio/i8042.c: 67 <- i8042 (return) [0]
drivers/input/serio/i8042.c: 60 -> i8042 (command) [0]
drivers/input/serio/i8042.c: 76 -> i8042 (parameter) [0]
drivers/input/serio/i8042.c: d3 -> i8042 (command) [0]
drivers/input/serio/i8042.c: f0 -> i8042 (parameter) [0]
drivers/input/serio/i8042.c: 0f <- i8042 (return) [0]
drivers/input/serio/i8042.c: d3 -> i8042 (command) [0]
drivers/input/serio/i8042.c: 56 -> i8042 (parameter) [0]
drivers/input/serio/i8042.c: a9 <- i8042 (return) [0]
drivers/input/serio/i8042.c: d3 -> i8042 (command) [0]
drivers/input/serio/i8042.c: a4 -> i8042 (parameter) [0]
drivers/input/serio/i8042.c: 5b <- i8042 (return) [0]
drivers/input/serio/i8042.c: d3 -> i8042 (command) [0]
drivers/input/serio/i8042.c: 5a -> i8042 (parameter) [0]
drivers/input/serio/i8042.c: a5 <- i8042 (return) [0]
drivers/input/serio/i8042.c: a7 -> i8042 (command) [0]
drivers/input/serio/i8042.c: 20 -> i8042 (command) [0]
drivers/input/serio/i8042.c: 76 <- i8042 (return) [0]
drivers/input/serio/i8042.c: a8 -> i8042 (command) [0]
drivers/input/serio/i8042.c: 20 -> i8042 (command) [0]
drivers/input/serio/i8042.c: 56 <- i8042 (return) [0]
drivers/input/serio/i8042.c: 60 -> i8042 (command) [0]
drivers/input/serio/i8042.c: 74 -> i8042 (parameter) [0]
drivers/input/serio/i8042.c: 60 -> i8042 (command) [0]
drivers/input/serio/i8042.c: 54 -> i8042 (parameter) [0]
drivers/input/serio/i8042.c: 60 -> i8042 (command) [0]
drivers/input/serio/i8042.c: 56 -> i8042 (parameter) [0]
drivers/input/serio/i8042.c: d4 -> i8042 (command) [0]
drivers/input/serio/i8042.c: f2 -> i8042 (parameter) [0]
drivers/input/serio/i8042.c: d4 -> i8042 (command) [99]
drivers/input/serio/i8042.c: ed -> i8042 (parameter) [99]
drivers/input/serio/i8042.c: fe <- i8042 (interrupt, aux, 0, timeout) [99]
drivers/input/serio/i8042.c: 60 -> i8042 (command) [99]
drivers/input/serio/i8042.c: 54 -> i8042 (parameter) [99]
drivers/input/serio/i8042.c: fe <- i8042 (flush, kbd) [113]
drivers/input/serio/i8042.c: 60 -> i8042 (command) [113]
drivers/input/serio/i8042.c: 56 -> i8042 (parameter) [113]
drivers/input/serio/i8042.c: d4 -> i8042 (command) [113]
drivers/input/serio/i8042.c: f2 -> i8042 (parameter) [113]
drivers/input/serio/i8042.c: 60 -> i8042 (command) [212]
drivers/input/serio/i8042.c: 54 -> i8042 (parameter) [212]
drivers/input/serio/i8042.c: fe <- i8042 (flush, kbd) [212]
serio: i8042 AUX port at 0x60,0x64 irq 12
drivers/input/serio/i8042.c: 60 -> i8042 (command) [212]
drivers/input/serio/i8042.c: 44 -> i8042 (parameter) [212]
drivers/input/serio/i8042.c: 60 -> i8042 (command) [212]
drivers/input/serio/i8042.c: 45 -> i8042 (parameter) [212]
drivers/input/serio/i8042.c: f2 -> i8042 (kbd-data) [212]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, kbd, 1) [215]
drivers/input/serio/i8042.c: ab <- i8042 (interrupt, kbd, 1) [217]
drivers/input/serio/i8042.c: 41 <- i8042 (interrupt, kbd, 1) [218]
drivers/input/serio/i8042.c: ed -> i8042 (kbd-data) [218]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, kbd, 1) [221]
drivers/input/serio/i8042.c: 00 -> i8042 (kbd-data) [221]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, kbd, 1) [224]
drivers/input/serio/i8042.c: f8 -> i8042 (kbd-data) [224]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, kbd, 1) [227]
drivers/input/serio/i8042.c: f4 -> i8042 (kbd-data) [227]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, kbd, 1) [231]
drivers/input/serio/i8042.c: f0 -> i8042 (kbd-data) [231]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, kbd, 1) [234]
drivers/input/serio/i8042.c: 02 -> i8042 (kbd-data) [234]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, kbd, 1) [237]
drivers/input/serio/i8042.c: f0 -> i8042 (kbd-data) [237]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, kbd, 1) [240]
drivers/input/serio/i8042.c: 00 -> i8042 (kbd-data) [240]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, kbd, 1) [243]
drivers/input/serio/i8042.c: 41 <- i8042 (interrupt, kbd, 1) [244]
input: AT Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1

