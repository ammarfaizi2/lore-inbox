Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264351AbUASWE3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 17:04:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264405AbUASWE3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 17:04:29 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:49387 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S264351AbUASWEZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 17:04:25 -0500
Date: Mon, 19 Jan 2004 23:04:13 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org,
       Hans Ulrich Niedermann <linux-kernel@n-dimensional.de>
Subject: Re: [2.6 patch] move rme96xx to Documentation/sound/oss/
Message-ID: <20040119220413.GS12027@fs.tum.de>
References: <20040113185432.GQ9677@fs.tum.de> <20040113115240.6aec2dea.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040113115240.6aec2dea.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 13, 2004 at 11:52:40AM -0800, Andrew Morton wrote:
> Adrian Bunk <bunk@fs.tum.de> wrote:
> >
> > The patch below moves the OSS rme96xx to Documentation/sound/oss/ .
> 
> It would be better to do this with a bk rename.  Please remind us when Linus
> returns.

Hi Linus,

in 2.6, all sound documentation with the exception of the OSS rme96xx 
documentation is under Documentation/sound/{alsa,oss}.

Please do the BK equivalent of a
  mv Documentation/sound/rme96xx \
     Documentation/sound/oss/

and apply the patch by Hans Ulrich Niedermann below.

TIA
Adrian

--- 1.18/sound/oss/Kconfig	Tue Dec 30 09:45:02 2003
+++ edited/sound/oss/Kconfig	Tue Jan 13 20:23:01 2004
@@ -1147,7 +1147,7 @@
 	help
 	  Say Y or M if you have a Hammerfall or Hammerfall light
 	  multichannel card from RME. If you want to acess advanced
-	  features of the card, read Documentation/sound/rme96xx.
+	  features of the card, read Documentation/sound/oss/rme96xx.
 
 config SOUND_AD1980
 	tristate "AD1980 front/back switch plugin"
