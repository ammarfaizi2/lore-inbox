Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272219AbTHDUCj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 16:02:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272215AbTHDUCT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 16:02:19 -0400
Received: from lingo.ece.uci.edu ([128.200.9.213]:47778 "EHLO
	lingo.ece.uci.edu") by vger.kernel.org with ESMTP id S272219AbTHDUBh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 16:01:37 -0400
Reply-To: <wsong@ece.uci.edu>
From: "Song Wang" <wsong@ece.uci.edu>
To: "Stefan Winter" <mail@stefan-winter.de>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: your HOWTO "2.6.0-test1 on RH90" - question
Date: Mon, 4 Aug 2003 13:02:12 -0700
Message-ID: <MEEKIEPDOBGHADOEHGGOCELECBAA.wsong@ece.uci.edu>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
In-Reply-To: <000501c35674$c39ac100$1202a8c0@WorkGroup>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

There is dependency between "Input device support" and virtul terminal.
In order to be able to see 'Virutal Terminal' in Character devices,
you have to set the 'Input devices (needed for keyboard, mouse,...)' from
'M' to 'Y' under  "Input device support".

I have updated my mini-how for this
(http://www.ags.uci.edu/~songw/kernel2.6-rh90-howto.txt)

-Song

-----Original Message-----
From: Stefan Winter [mailto:mail@stefan-winter.de]
Sent: Wednesday, July 30, 2003 1:30 AM
To: wsong@ece.uci.edu
Subject: your HOWTO "2.6.0-test1 on RH90" - question


Hello,

i am trying to get a 2.6.0-test2 up and running on my laptop. I experienced
the same problems as you have, especially in point 2 of your HOWTO (blank
screen, no virtual terminal).
Problem is: under character devices, I don´t find any option "Virtual
terminal", which used to be there under 2.4.x. And if I search through
.config, I do _not_ see the lines CONFIG_VGA_CONSOLE, CONFIG_VT,
CONFIG_VT_CONSOLE.
So, my question is: is there a dependency that prevents me from seeing
"Virtual terminal"? Or what else could be wrong? I was using a make
menuconfig with gcc 3.3.

Greetings,

Stefan Winter

