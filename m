Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129859AbRAERxu>; Fri, 5 Jan 2001 12:53:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131389AbRAERxd>; Fri, 5 Jan 2001 12:53:33 -0500
Received: from porgy.srv.nld.sonera.net ([195.66.15.137]:32812 "EHLO
	porgy.srv.nld.sonera.net") by vger.kernel.org with ESMTP
	id <S129859AbRAERxV>; Fri, 5 Jan 2001 12:53:21 -0500
Message-ID: <000d01c07740$516a30e0$fd1942c3@bluescreen>
From: "-=da TRoXX=-" <TRoXX@LiquidXTC.nl>
To: <linux-kernel@vger.kernel.org>
Subject: Framebuffer as a module
Date: Fri, 5 Jan 2001 18:52:45 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

please CC me on any replies to this message since I'm not subscribed to the
list (just toooo much mail for me)

I have a very simple question:
I used to compile-in my framebuffer-device in the kernel
then i just appended "video=tdfxfb:1024x768-32@70" in lilo.conf and it
worked..

now i compiled it as a module, and want modprobe to start it up for me..
how can this be done?
modprobe tdfxfb 1024x768-32@70
won't work, because there is no '=' sign in it so modprobe doesn't recognize
it as a parameter, and doesn't pass it.

so what can i do about it?

tnx in advance :)



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
