Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133111AbRBEQTd>; Mon, 5 Feb 2001 11:19:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135255AbRBEQTY>; Mon, 5 Feb 2001 11:19:24 -0500
Received: from agnus.shiny.it ([194.20.232.6]:63498 "EHLO agnus.shiny.it")
	by vger.kernel.org with ESMTP id <S135253AbRBEQTO>;
	Mon, 5 Feb 2001 11:19:14 -0500
Message-ID: <XFMail.010205171914.pochini@shiny.it>
X-Mailer: XFMail 1.3 [p0] on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
Date: Mon, 05 Feb 2001 17:19:14 +0100 (CET)
From: Giuliano Pochini <pochini@shiny.it>
To: linux-kernel@vger.kernel.org
Subject: 2.4.1 & zombies
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Last week we put 2.4.1 in our web server. (2.2 really couldn't
do the job - continue stalls, load average up to 800, etc.).
2.4 performs really nicely. Now the load avg rarely goes
over 4 and the machine is always responsive.
I noticed that zombies tend to exist for much more time than
with 2.2.x. e.g. in this moment, with medium load (700 httpd's),
there are around 70 zombie cgi's. There aren't processes stuck
in Z, they simply take more time to die. Strange.

Bye.
    Giuliano Pochini ->)|(<- Shiny Corporation {AS6665} ->)|(<-

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
