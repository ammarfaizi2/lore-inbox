Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262428AbVBDLdZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262428AbVBDLdZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 06:33:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263499AbVBDLck
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 06:32:40 -0500
Received: from pop.gmx.net ([213.165.64.20]:23501 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263417AbVBDLcQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 06:32:16 -0500
X-Authenticated: #26200865
Message-ID: <42035D5A.2030703@gmx.net>
Date: Fri, 04 Feb 2005 12:32:42 +0100
From: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.7.2) Gecko/20040906
X-Accept-Language: de, en
MIME-Version: 1.0
To: Oliver Neukum <oliver@neukum.org>
CC: Pavel Machek <pavel@ucw.cz>, ncunningham@linuxmail.org,
       ACPI List <acpi-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Reliable video POSTing on resume
References: <20050122134205.GA9354@wsc-gmbh.de> <4202DF7B.2000506@gmx.net> <20050204074802.GD1086@elf.ucw.cz> <200502041126.14386.oliver@neukum.org>
In-Reply-To: <200502041126.14386.oliver@neukum.org>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oliver Neukum schrieb:
> Am Freitag, 4. Februar 2005 08:48 schrieb Pavel Machek:
> 
>>What about simply blocking all video accesses before disk (etc) is
>>resumed, so that "normal" (not locked in memory) application can be
>>used?
> 
> Very bad for debugging. Genuine serial ports are becoming rarer.

As a bonus, even genuine serial ports may be in undefined state after
resume. I'm unfortunate enough to have a brand new notebook with
serial port, but the serial console code will print garbage after
resume until I do a
echo foo >/dev/ttyS0

I've already sent mail to linux-serial for that problem, but the
list appears to be dead. Any pointers to the right contact would
be appreciated.

Regards,
Carl-Daniel
-- 
http://www.hailfinger.org/
