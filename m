Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261573AbUB1KbE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Feb 2004 05:31:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261386AbUB1KbE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Feb 2004 05:31:04 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:17096 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S261573AbUB1Ka7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Feb 2004 05:30:59 -0500
Date: Sat, 28 Feb 2004 11:30:30 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org,
       Hans Ulrich Niedermann <linux-kernel@n-dimensional.de>
Subject: Re: [2.6 patch] move rme96xx to Documentation/sound/oss/ (fwd)
Message-ID: <20040228103030.GN5499@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2i
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
