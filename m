Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290714AbSAYQ0d>; Fri, 25 Jan 2002 11:26:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290506AbSAYQ0W>; Fri, 25 Jan 2002 11:26:22 -0500
Received: from APuteaux-101-2-1-180.abo.wanadoo.fr ([193.251.40.180]:58892
	"EHLO inet6.dyn.dhs.org") by vger.kernel.org with ESMTP
	id <S290714AbSAYQ0P>; Fri, 25 Jan 2002 11:26:15 -0500
Date: Fri, 25 Jan 2002 17:21:55 +0100
From: Lionel Bouton <Lionel.Bouton@inet6.fr>
To: linux-kernel@vger.kernel.org
Cc: bobh@n-cantrell.demon.co.uk, jussi.laako@imagesoft.fi, wfilardo@fuse.net,
        dani@ngrt.de
Subject: [PATCH RFC] SiS 2.4 IDE driver update (+= ATA16|ATA33|ATA100)
Message-ID: <20020125172155.A11517@bouton.inet6-interne.fr>
Mail-Followup-To: linux-kernel@vger.kernel.org, bobh@n-cantrell.demon.co.uk,
	jussi.laako@imagesoft.fi, wfilardo@fuse.net, dani@ngrt.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

New driver for SiS IDE chipsets with support for ATA16 to ATA100
chip generations.
I added support for ATAT16 and ATA33 chipsets to my previous patches and
rewrote large parts of the original driver.
The diff is 33345 bytes long (longer than the whole sis5513.c file in fact)
so I put it on a web server (thanks go to my employer for the web hosting):

http://inet6.dyn.dhs.org/sponsoring/sis5513/sis.patch.20020123_1

On the following page you'll find more information, links to current
sis5513.c code and previous patches:
http://inet6.dyn.dhs.org/sponsoring/sis5513/index.html

As always, success and failure reports are welcomed.
Comments on coding style are too.

LB.
