Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131460AbQLZXCo>; Tue, 26 Dec 2000 18:02:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131910AbQLZXCf>; Tue, 26 Dec 2000 18:02:35 -0500
Received: from 13dyn24.delft.casema.net ([212.64.76.24]:11023 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S131460AbQLZXCa>; Tue, 26 Dec 2000 18:02:30 -0500
Message-Id: <200012262231.XAA15382@cave.bitwizard.nl>
Subject: Re: About Celeron processor memory barrier problem
In-Reply-To: <Pine.LNX.4.10.10012261012330.8122-100000@penguin.transmeta.com>
 from Linus Torvalds at "Dec 26, 2000 10:14:03 am"
To: Linus Torvalds <torvalds@transmeta.com>
Date: Tue, 26 Dec 2000 23:31:55 +0100 (MET)
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, Tim Wright <timw@splhi.com>,
        Kai Henningsen <kaih@khms.westfalen.de>, linux-kernel@vger.kernel.org
From: R.E.Wolff@BitWizard.nl (Rogier Wolff)
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> > If we do that I'd rather see a make autoconfig that does the lot from
> > proc/pci etc 8)
> 
> Good point. No point in adding a new config option, we should just have a
> new configurator instead. Of course, it can't handle many of the
> questions, so it would still have to fall back on asking.
> 
> That _would_ be a nice addition eventually. It's a bigger project than the
> one I envisioned, though.

The way I interpreted Alan is that 

	make autoconfig

would spit out the default config, modified for the current setup, as
far as possible. So "my PCI devices" would be configured into the
kernel automatically (the way Linus likes it ;-). Similarly the
"complicated" CPU selection would be "don't touch unless you really
know what you're doing: autoconfig analized your cpuinfo". 

It would at least NOT INPACT anything in the current setup. 

				Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2137555 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* There are old pilots, and there are bold pilots. 
* There are also old, bald pilots. 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
