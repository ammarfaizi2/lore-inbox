Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265999AbUE1JLL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265999AbUE1JLL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 05:11:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266003AbUE1JLL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 05:11:11 -0400
Received: from smtp9.wanadoo.fr ([193.252.22.22]:32799 "EHLO
	mwinf0902.wanadoo.fr") by vger.kernel.org with ESMTP
	id S265999AbUE1JLG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 05:11:06 -0400
Message-ID: <40B7022F.1020905@reolight.net>
Date: Fri, 28 May 2004 11:11:11 +0200
From: Auzanneau Gregory <mls@reolight.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.6) Gecko/20040526 Debian/1.6-6
X-Accept-Language: fr, fr-fr, en, en-gb, en-us
MIME-Version: 1.0
To: "Zhu, Yi" <yi.zhu@intel.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: idebus setup problem (2.6.7-rc1)
References: <Pine.LNX.4.44.0405281244220.22881-100000@mazda.sh.intel.com>
In-Reply-To: <Pine.LNX.4.44.0405281244220.22881-100000@mazda.sh.intel.com>
X-Enigmail-Version: 0.83.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Zhu, Yi a écrit :
> My bad. I missed ide_setup(), please try below patch.

Patch works fine for me:
Kernel command line: BOOT_IMAGE=LinuxNEW ro root=304 idebus=66
ide_setup: idebus=66
ide: Assuming 66MHz system bus speed for PIO modes


Thanks a lot,

-- 
Auzanneau Grégory
GPG 0x99137BEE
