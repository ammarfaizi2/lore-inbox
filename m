Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286343AbSAMQDu>; Sun, 13 Jan 2002 11:03:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286358AbSAMQDl>; Sun, 13 Jan 2002 11:03:41 -0500
Received: from pa147.antoniuk.sdi.tpnet.pl ([213.25.59.147]:20864 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S286343AbSAMQD0>; Sun, 13 Jan 2002 11:03:26 -0500
Date: Sun, 13 Jan 2002 17:02:28 +0100
From: Jacek =?iso-8859-2?Q?Pop=B3awski?= <jpopl@interia.pl>
To: linux-kernel@vger.kernel.org
Subject: radeonfb
Message-ID: <20020113170228.A1529@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I compiled 2.4.18-pre3 with radeonfb patch. Console works without problems, but
every time I start fbi or fbtv:
- colors are bad (depth problem)
- when I quit application - monitor turns off (probably bad mode setting, but
  why mode is changed?), it turns on when I switch virtual console (then I can
  go back)
When I use "fbset 800x600-100" I have 24 bit depth, but I can't set
800x600-24@100 as lilo parameter. Only 800x600-16@100 works OK. 
Is there any radeonfb documentation or project page available?

-- 
decopter - free SDL/OpenGL simulator under heavy development
download it from http://decopter.sourceforge.net
