Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263065AbSJBLwY>; Wed, 2 Oct 2002 07:52:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263063AbSJBLwY>; Wed, 2 Oct 2002 07:52:24 -0400
Received: from warrior.services.quay.plus.net ([212.159.14.227]:29923 "HELO
	warrior.services.quay.plus.net") by vger.kernel.org with SMTP
	id <S263065AbSJBLwX>; Wed, 2 Oct 2002 07:52:23 -0400
Date: Wed, 2 Oct 2002 12:30:53 +0100
From: Stig Brautaset <s.brautaset@wmin.ac.uk>
To: linux-kernel@vger.kernel.org
Subject: 2.5.40: menuconfig: no choice of keyboards
Message-ID: <20021002113053.GA482@arwen.brautaset.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-KeyServer: wwwkeys.nl.pgp.net
X-PGP/GnuPG-Key: 9336ADC1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nothing happens if I go to the "Input Device Support" section in
menuconf, and pick "Keyboards"; I get no new options. Got around it by
manually selecting a keyboard in .config to be able to test it further.
Either I chose the wrong one, or it just doesn't build it anyway, 'cause 
the machine would not respond on boot. 

Does it have something to do with the menuconfig bug reported elsewhere?
Here's mine, anyway:

/bin/sh ./scripts/Menuconfig arch/i386/config.in
Using defaults found in .config
Preparing scripts: functions,
parsing........................................................................../scripts/Menuconfig:
./MCmenu74: line 56: syntax error near unexpected token `fi'
./scripts/Menuconfig: ./MCmenu74: line 56: `fi'
...............done.

Stig
-- 
brautaset.org
