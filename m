Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266158AbTGLQJE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jul 2003 12:09:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266114AbTGLQIu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jul 2003 12:08:50 -0400
Received: from ip212-226-133-178.adsl.kpnqwest.fi ([212.226.133.178]:41176
	"EHLO jumper") by vger.kernel.org with ESMTP id S266165AbTGLQHU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jul 2003 12:07:20 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: hang with pcmcia wlan card
From: Jaakko Niemi <liiwi@lonesom.pp.fi>
References: <87fzldxcf5.fsf@jumper.lonesom.pp.fi>
In-Reply-To: <87fzldxcf5.fsf@jumper.lonesom.pp.fi>
Date: Sat, 12 Jul 2003 19:22:53 +0300
Message-ID: <873chbyasi.fsf@jumper.lonesom.pp.fi>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Hi,
>
>My laptop (thinkpad 570e) hangs hard straight after bringing up
>interface with d-link dwl-650 wlan card. 2.5.73-bk1 works and
>2.5.73-bk2 to 2.5.75-bk1 hang. If I boot without the card,
>everything comes up, but inserting the card results to a hang.
>Setting nmi_watchdog=2 has no effect.

 Ok, bit more info: same thing happens with edimax 8139 based
 cardbus nic also. I've disabled apm and acpi from kernel 
 and going to start going through the pci changes between 
 2.5.73-bk1 and bk2. Any clues would be much appreciated.

                --j
