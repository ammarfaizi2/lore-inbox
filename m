Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263077AbSKEAbG>; Mon, 4 Nov 2002 19:31:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263081AbSKEAbG>; Mon, 4 Nov 2002 19:31:06 -0500
Received: from mail11.bigmailbox.com ([209.132.220.42]:5354 "EHLO
	mail11.bigmailbox.com") by vger.kernel.org with ESMTP
	id <S263077AbSKEAbD>; Mon, 4 Nov 2002 19:31:03 -0500
Date: Mon, 4 Nov 2002 16:37:32 -0800
Message-Id: <200211050037.gA50bWp31127@mail11.bigmailbox.com>
Content-Type: text/plain
Content-Disposition: inline
Content-Transfer-Encoding: binary
X-Mailer: MIME-tools 4.104 (Entity 4.116)
Mime-Version: 1.0
X-Originating-Ip: [218.2.151.77]
From: "Jim Zeus" <jimzeus@edguy.nu>
To: linux-kernel@vger.kernel.org
Subject: How to implement a virtual TTY device?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I am trying to implement a virtual TTY device which relate to a serial
port through some complex protocol, but I have no experience about
it.So can anybody tell me where should I put the operation functions ?
Implement a new tty driver or just put the operation in the
functions(tty_open,tty_read, etc) which in the tty_io.c or something
else(maybe as a line dicipline:)?

In my opinion, to implement the code in the tty_driver will let the code be with the hardware driver together,and its not good I think.
But to implement the code in tty_io.c will let the length of tty_io.c longer and longer...
So is there any suggestion or something like this which had been implemented ?

TIA




------------------------------------------------------------
Edguy's Official Website - http://www.edguy.nu


---------------------------------------------------------------------
Express yourself with a super cool email address from BigMailBox.com.
Hundreds of choices. It's free!
http://www.bigmailbox.com
---------------------------------------------------------------------
