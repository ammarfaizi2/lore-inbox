Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262850AbSJAWPI>; Tue, 1 Oct 2002 18:15:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262852AbSJAWPI>; Tue, 1 Oct 2002 18:15:08 -0400
Received: from host-63-69-231-252.verestar.net ([63.69.231.252]:40606 "EHLO
	venus.tis.com.ar") by vger.kernel.org with ESMTP id <S262850AbSJAWPF>;
	Tue, 1 Oct 2002 18:15:05 -0400
Date: Tue, 1 Oct 2002 19:20:18 -0300
To: mec@shout.net
Cc: linux-kernel@vger.kernel.org
Subject: Fatal error in menuconfig
Message-ID: <20021001192018.A1225@technisys.com.ar>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22i
From: =?iso-8859-1?Q?Nicol=E1s_Lichtmaier?= <nick@technisys.com.ar>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm getting this while trying to access the alsa sound section in 2.5.40:

---------------------------------------------------------------
Menuconfig has encountered a possible error in one of the kernel's
configuration files and is unable to continue.  Here is the error
report:

 Q> ./scripts/Menuconfig: line 823: MCmenu74: command not found

Please report this to the maintainer <mec@shout.net>.  You may also
send a problem report to <linux-kernel@vger.kernel.org>.

Please indicate the kernel version you are trying to configure and
which menu you were trying to enter when this error occurred.

make: *** [menuconfig] Error 1
---------------------------------------------------------------

If I redirect stderr to a file I also see this in that file:

./scripts/Menuconfig: ./MCmenu74: line 56: syntax error near unexpected token `fi'
./scripts/Menuconfig: ./MCmenu74: line 56: `fi'
make: *** [menuconfig] Error 1

Thanks!
