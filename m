Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276255AbRJCNei>; Wed, 3 Oct 2001 09:34:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276266AbRJCNe2>; Wed, 3 Oct 2001 09:34:28 -0400
Received: from web11804.mail.yahoo.com ([216.136.172.158]:10761 "HELO
	web11804.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S276255AbRJCNeM>; Wed, 3 Oct 2001 09:34:12 -0400
Message-ID: <20011003133440.28925.qmail@web11804.mail.yahoo.com>
Date: Wed, 3 Oct 2001 15:34:40 +0200 (CEST)
From: =?iso-8859-1?q?Etienne=20Lorrain?= <etienne_lorrain@yahoo.fr>
Subject: New Input PS/2 driver
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Simmons wrote:
> To use the keyboard driver you need to 
> 1) enable the input core and keyboard support in the input menu. 

  Would be nice to change the comment describing the Keyboard core
 support (CONFIG_INPUT_KEYBDEV) in this patch: people (as dumb me)
 may read the help in menuconfig and say:
 I have no USB HID or ADB keyboard...
 Recompile, reboot => no keyboard, no control-alt-del => Reset (fsck...).

  Else it is working here on a P133 with nothing special (std PS2 mouse).

  BTW you just undefine I8042_OVERRIDE_KEYLOCK but this define is
 never used.

  Etienne.

___________________________________________________________
Do You Yahoo!? -- Un e-mail gratuit @yahoo.fr !
Yahoo! Courrier : http://fr.mail.yahoo.com
