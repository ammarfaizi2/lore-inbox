Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289568AbSBNCk1>; Wed, 13 Feb 2002 21:40:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289577AbSBNCkH>; Wed, 13 Feb 2002 21:40:07 -0500
Received: from lsanca1-ar4-058-092.lsanca1.dsl.gtei.net ([4.41.58.92]:30710
	"EHLO blue") by vger.kernel.org with ESMTP id <S289568AbSBNCj4>;
	Wed, 13 Feb 2002 21:39:56 -0500
Date: Wed, 13 Feb 2002 18:39:19 -0800
From: Eric Warmenhoven <warmenhoven@yahoo.com>
To: linux-kernel@vger.kernel.org
Subject: ALSA Via 686A build problem, patch
Message-ID: <20020214023919.GA1111@lsanca1-ar4-057-226.lsanca1.dsl.gtei.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="IJpNTDwzlM2Ie8A6"
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--IJpNTDwzlM2Ie8A6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

I had trouble building 2.5.5-pre1 with ALSA and its Via 82C686A driver,
because in linux/sound/pci/ac97/Makefile, there seems to be a typo. I've
attached a patch.

Eric

--IJpNTDwzlM2Ie8A6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ac97typo.patch"

--- linux-2.5.5-pre1/sound/pci/ac97/Makefile	Wed Feb 13 18:31:53 2002
+++ linux/sound/pci/ac97/Makefile		Wed Feb 13 16:43:23 2002
@@ -21,7 +21,7 @@
 obj-$(CONFIG_SND_ICE1712) += snd-ac97-codec.o
 obj-$(CONFIG_SND_INTEL8X0) += snd-ac97-codec.o
 obj-$(CONFIG_SND_MAESTRO3) += snd-ac97-codec.o
-obj-$(CONFIG_SND_VIA686A) += snd-ac97-codec.o
+obj-$(CONFIG_SND_VIA686) += snd-ac97-codec.o
 obj-$(CONFIG_SND_VIA8233) += snd-ac97-codec.o
 obj-$(CONFIG_SND_ALI5451) += snd-ac97-codec.o
 obj-$(CONFIG_SND_CS46XX) += snd-ac97-codec.o

--IJpNTDwzlM2Ie8A6--
