Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265694AbVBEBOJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265694AbVBEBOJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 20:14:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265842AbVBEBOI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 20:14:08 -0500
Received: from imap.gmx.net ([213.165.64.20]:47799 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S265694AbVBEBNn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 20:13:43 -0500
X-Authenticated: #26200865
Message-ID: <42041DE5.2070303@gmx.net>
Date: Sat, 05 Feb 2005 02:14:13 +0100
From: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.7.2) Gecko/20040906
X-Accept-Language: de, en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: Jon Smirl <jonsmirl@gmail.com>, ncunningham@linuxmail.org,
       ACPI List <acpi-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [RFC] Reliable video POSTing on resume
References: <20050122134205.GA9354@wsc-gmbh.de> <4201825B.2090703@gmx.net> <e796392205020221387d4d8562@mail.gmail.com> <420217DB.709@gmx.net> <4202A972.1070003@gmx.net> <20050203225410.GB1110@elf.ucw.cz> <1107474198.5727.9.camel@desktop.cunninghams> <4202DF7B.2000506@gmx.net> <9e47339105020321031ccaabb@mail.gmail.com> <420367CF.7060206@gmx.net> <20050204163019.GC1290@elf.ucw.cz>
In-Reply-To: <20050204163019.GC1290@elf.ucw.cz>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek schrieb:
> 
> I do not understand how initramfs fits into picture... Plus lot of
> people (me :-) do not use initramfs...

Well, an initrd which is never unmounted should work, too. On SUSE,
"mkdir /initrd" and see what you've been missing. I don't know why
that directory doesn't exist by default except for the reason that
freeing the initrd frees some memory.


Regards,
Carl-Daniel
-- 
http://www.hailfinger.org/
