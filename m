Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129137AbRB1Jcn>; Wed, 28 Feb 2001 04:32:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129155AbRB1Jce>; Wed, 28 Feb 2001 04:32:34 -0500
Received: from smtp-rt-3.wanadoo.fr ([193.252.19.155]:17837 "EHLO
	apicra.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S129137AbRB1JcT>; Wed, 28 Feb 2001 04:32:19 -0500
Message-ID: <3a9cc5953b575371@citronier.wanadoo.fr> (added by
	    citronier.wanadoo.fr)
From: "Sébastien HINDERER" <jrf3@wanadoo.fr>
To: <linux-kernel@vger.kernel.org>
Subject: Keyboard simulation
Date: Wed, 28 Feb 2001 10:38:03 -0000
X-MSMail-Priority: Normal
X-Priority: 3
X-Mailer: Microsoft Internet Mail 4.70.1161
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm writting a driver so that my soft braille display can work with the
BRLTTY daemon.
My braille computer contains a braille display, and a braille keyboard
which I can use to enter characters that are transmitted to the computer.
When my driver gets "normla" chars, he writes them to /dev/console. So for
applications, it looks as if they came from the normal keyboard.
Now, I'd like to be able to change the current virtual console and to view
previously displayed screens (equivalent to shift+page up) just by pressing
keys on the braille keyboard.
So my question is: What should my driver do when it detects that the
"change tty" key or the "scroll key" was pressed on the braille keyboard?
Should the driver change the current tty itself (scroll the screen), or is
it possible to call the kernel exactly like the normal keyboard driver
would do (transmit keycodes), saying "alt + function key was pressed", or
"shift + page up/down was pressed".
Thank you very much for help. Sébastien.

