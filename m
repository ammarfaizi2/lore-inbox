Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261879AbSJNI5p>; Mon, 14 Oct 2002 04:57:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261897AbSJNI5p>; Mon, 14 Oct 2002 04:57:45 -0400
Received: from postfix4-1.free.fr ([213.228.0.62]:33670 "EHLO
	postfix4-1.free.fr") by vger.kernel.org with ESMTP
	id <S261879AbSJNI5o>; Mon, 14 Oct 2002 04:57:44 -0400
Date: Mon, 14 Oct 2002 11:07:55 +0200
From: Romain Lievin <rlievin@free.fr>
To: rmk@arm.linux.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: Serial API ('serport' ?)
Message-ID: <20021014090755.GB2911@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I would like to know whether a kind of parport exists for the serial ports.
This will allow me to do some low level accesses on the serial port pins (CTS/RTS & DSR/DTR).
I need to implement a bit-banging access on the serial port which can coexist with the other serial ports.

I can not use request_region/release_region because the region has already been locked by the serial port driver.

Any idea ?

--
Romain Lievin, aka 'roms'       <roms@lpg.ticalc.org>
Web site                        <http://lpg.ticalc.org/prj_tilp>
"Linux, y'a moins bien mais c'est plus cher !"
