Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267256AbUHTORa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267256AbUHTORa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 10:17:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267439AbUHTOR3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 10:17:29 -0400
Received: from imag.imag.fr ([129.88.30.1]:15515 "EHLO imag.imag.fr")
	by vger.kernel.org with ESMTP id S267256AbUHTORJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 10:17:09 -0400
Date: Fri, 20 Aug 2004 16:09:33 +0200 (MEST)
From: "emmanuel.colbus@ensimag.imag.fr" <colbuse@ensisun.imag.fr>
X-X-Sender: colbuse@ensisun
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: Screen off while booting
Message-ID: <Pine.GSO.4.40.0408201509360.18695-100000@ensisun>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-Information: Please contact the ISP for more information
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I've discovered a very curious behaviour on my Linux laptop (but please
notice first that it is causing no problem to any normal user and that
it is very easy to avoid, therefore, it's importance is extremely low, and
I am just reporting it because I think it could interest you - it's not
annoying myself too. Notice also that only a very strange behaviour from
the user can lead to this situation).


1. Summary of the problem :

The kernel switches the screen off every time the users switches between
graphical and text console.


2. Full description of the problem :

My laptop gives it's users the possibility to switch the screen off/on by
pressing at the same time "Fn" and F7 on the keyboard. One time, I had the
idea to switch the screen off before booting (while LILO was waiting from
me to strike "enter"). I had to switch it back on to see something after
the boot had completed (ie. normal behaviour), but I noticed that the screen
was also set off every time I made a manipulation, for example console
switching, which would theoretically have switched it on if it was off
before.

In other words, the "on" and "off" states of the screen were confused and
used instead of each other. I think it is due to the fact that the
kernel is not expecting to boot while the screen is turned off this way.


3. Keywords
kernel (?)
screen
console switching


4. Kernel version
I have a Mandrake 9.2.1 with kernel 2.4.22-26mdk.


5. Messages
No one.


6. How to reproduce the problem
Just boot a laptop with screen turned off using this keyboard feature
before actual booting. (Of course, I don't know if it's working on every
laptops, but it's seems me this way.)


7. Environment
7.1 Computer : IBM Thinkpad t40.
7.2 Processor : Intel centrino.
7.3 Module information : (I don't know. I've never changed anything to the
standard modules configuration. I've not my laptop here, sorry).
7.4 Loaded driver and hardware information :
7.5 PCI information :
7.6 SCSI information :
(Well, I don't know anymore. Are these informations relevant? If they are,
just ask me, I'll get them and tell you.)


X. Other notes :
Normally, this off-switching of the screen can also be caused by the
absence of any activity during a while.

As i stated it before, the user has to behave very "curiously" to get this
behaviour.

Rebooting fixes the problem.



I think this issue should be given the absolute lowest priority. It
can also be considered as an informative note, not needing to be fixed at
all, because nobody uses his computer this way.

I posted this report because I think it could interest you.




(I would like to be personnally CC'ed the (eventual) answers/comments
posted to the list in response to my posting, because I am not subscriber
of the list. My own e-mail is : emmanuel.colbus@ensimag.imag.fr )


