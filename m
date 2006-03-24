Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751493AbWCXOgU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751493AbWCXOgU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 09:36:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751495AbWCXOgT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 09:36:19 -0500
Received: from mail.gmx.net ([213.165.64.20]:45285 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751493AbWCXOgT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 09:36:19 -0500
Date: Fri, 24 Mar 2006 15:36:17 +0100 (MET)
From: "Uwe Bugla" <uwe.bugla@gmx.de>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Adam Belay <ambx1@neo.rr.com>, linux-kernel@vger.kernel.org,
       Jaroslav Kysela <perex@suse.cz>,
       Matthieu Castet <castet.matthieu@free.fr>,
       Li Shaohua <shaohua.li@intel.com>, Andrew Morton <akpm@osdl.org>,
       Thorsten Knabe <linux@thorsten-knabe.de>, Takashi Iwai <tiwai@suse.de>
MIME-Version: 1.0
Subject: bug in 2.6.16-mm1 - snd-ad1816a is not being loaded
X-Priority: 3 (Normal)
X-Authenticated: #8359428
Message-ID: <19226.1143210977@www043.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,
I've tried Bjorn Hellgaas' patch which is included in 2.6.16-mm1. Thanks for
his attempts. But the problem still persists:
snd-ad1816a still refuses to load and dmesg still talks about a PnP
configuration error. If you need additional information, please tell me how
to produce it. 2.6.16 without mm1 works fine so far.

Ciao
Uwe
P. S.: In the first lines of dmesg the card is being recognized and the card
ID is being printed out to the console. But as soon as it goes to loading
the driver module the whole thing is broken and the module is not being
loaded, while dmesg prints out a PnP configuration error.

-- 
Bis zu 70% Ihrer Onlinekosten sparen: GMX SmartSurfer!
Kostenlos downloaden: http://www.gmx.net/de/go/smartsurfer
