Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422838AbWAMTSK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422838AbWAMTSK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 14:18:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422839AbWAMTSK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 14:18:10 -0500
Received: from amun.rz.tu-clausthal.de ([139.174.2.12]:7118 "EHLO
	amun.rz.tu-clausthal.de") by vger.kernel.org with ESMTP
	id S1422838AbWAMTSI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 14:18:08 -0500
From: "Hemmann, Volker Armin" <volker.armin.hemmann@tu-clausthal.de>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: Fw: two (little) problems wit 2.6.15-git7 one with build, one with acpi
Date: Fri, 13 Jan 2006 20:18:03 +0100
User-Agent: KMail/1.9
References: <20060112231528.025c3a0b.akpm@osdl.org>
In-Reply-To: <20060112231528.025c3a0b.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200601132018.04013.volker.armin.hemmann@tu-clausthal.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Friday 13 January 2006 08:15, you wrote:
> Volker, I think the `make install' thing is fixed, or will soon be.
>
> If the resume problem doesn't get fixed within the next few days, please
> raise a report at bugzilla.kernel.org.
>
> This is a regression wrt 2.6.15, so we're keen to fix it.
>

I tried -git8 last night.
make all modules_install install gave me again this error:

if [ -r System.map -a -x /sbin/depmod ]; then /sbin/depmod -ae -F System.map  
2.6.15-git8; fi
WARNING: Couldn't open directory /lib/modules/2.6.15-git8: No such file or 
directory
FATAL: Could not open /lib/modules/2.6.15-git8/modules.dep.temp for writing: 
No such file or directory
make: *** [_modinst_post] Fehler 1


and trying echo mem > /sys/power/state again made my box more or less dead.
I had to pull the plug, because the reset switch did not work.

I will try the nexft git version this night, but I have to wait some more 
hours.


Glück Auf
Volker
