Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271505AbRICIbR>; Mon, 3 Sep 2001 04:31:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271514AbRICIbH>; Mon, 3 Sep 2001 04:31:07 -0400
Received: from mx6.port.ru ([194.67.57.16]:2570 "EHLO smtp6.port.ru")
	by vger.kernel.org with ESMTP id <S271505AbRICIa6>;
	Mon, 3 Sep 2001 04:30:58 -0400
From: Samium Gromoff <_deepfire@mail.ru>
Message-Id: <200109031253.f83CrlK26536@vegae.deep.net>
Subject: first fruits
To: linux-kernel@vger.kernel.org
Date: Mon, 3 Sep 2001 12:53:46 +0000 (UTC)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

          Hello folks, here are first fruits.
    One problem with it: i`m not that sure that Keith`s .config generator
  wasnt wrong here - "unknown architecture" sounds verly much like it...

*note - thet was after 15 minutes after compile start (p166)

epson1355fb.c:73: #error unknown architecture
epson1355fb.c: In function `disable_hw_cursor':
epson1355fb.c:96: warning: implicit declaration of function `e1355_read_reg'
epson1355fb.c:98: warning: implicit declaration of function `e1355_write_reg'
epson1355fb.c: In function `e1355_set_bpp':
epson1355fb.c:185: warning: implicit declaration of function `e1355_write_reg16'epson1355fb.c: In function `dump_panel_data':
epson1355fb.c:241: warning: implicit declaration of function `e1355_read_reg16'
epson1355fb.c: In function `e1355_set_disp':
epson1355fb.c:435: `E1355_FB_BASE' undeclared (first use in this function)
epson1355fb.c:435: (Each undeclared identifier is reported only once
epson1355fb.c:435: for each function it appears in.)
epson1355fb.c:433: warning: `d' might be used uninitialized in this function
epson1355fb.c: At top level:
epson1355fb.c:80: warning: `current_par_valid' defined but not used
epson1355fb.c:229: warning: `dump_panel_data' defined but not used
make[3]: *** [epson1355fb.o] Error 1
make[3]: Leaving directory `/usr/src/linux/drivers/video'
make[2]: *** [first_rule] Error 2
make[2]: Leaving directory `/usr/src/linux/drivers/video'
make[1]: *** [_subdir_video] Error 2
make[1]: Leaving directory `/usr/src/linux/drivers'
make: *** [_dir_drivers] Error 2

cheers,
 Sam
