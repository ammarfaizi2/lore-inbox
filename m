Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265119AbUAMT1R (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 14:27:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265126AbUAMT1R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 14:27:17 -0500
Received: from bender.bawue.de ([193.7.176.20]:22987 "EHLO bender.bawue.de")
	by vger.kernel.org with ESMTP id S265119AbUAMT1P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 14:27:15 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: Adrian Bunk <bunk@fs.tum.de>, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] move rme96xx to Documentation/sound/oss/
In-Reply-To: <20040113185432.GQ9677@fs.tum.de> (Adrian Bunk's message of
 "Tue, 13 Jan 2004 19:54:32 +0100")
References: <20040113185432.GQ9677@fs.tum.de>
From: Hans Ulrich Niedermann <linux-kernel@n-dimensional.de>
Date: Tue, 13 Jan 2004 20:26:29 +0100
Message-ID: <86d69nzm3e.fsf@n-dimensional.de>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Reasonable Discussion,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@fs.tum.de> writes:

> In 2.6, all sound documentation with the exception of the OSS rme96xx 
> documentation is under Documentation/sound/{alsa,oss}.
>
> The patch below moves the OSS rme96xx to Documentation/sound/oss/ .
>
> diffstat output:
>
>  Documentation/sound/oss/rme96xx |  767 ++++++++++++++++++++++++++++++++
>  Documentation/sound/rme96xx     |  767 --------------------------------
>  2 files changed, 767 insertions(+), 767 deletions(-)

Please also apply the following, while you're at it.

Uli

===== sound/oss/Kconfig 1.18 vs edited =====
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
