Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262117AbTIMK4L (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Sep 2003 06:56:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262114AbTIMK4L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Sep 2003 06:56:11 -0400
Received: from pf138.torun.sdi.tpnet.pl ([213.76.207.138]:17926 "EHLO
	centaur.culm.net") by vger.kernel.org with ESMTP id S262117AbTIMK4K convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Sep 2003 06:56:10 -0400
From: Witold Krecicki <adasi@kernel.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: SII SATA request size limit
Date: Sat, 13 Sep 2003 12:56:06 +0200
User-Agent: KMail/1.5.9
References: <200309121755.20746.eu@marcelopenna.org>
In-Reply-To: <200309121755.20746.eu@marcelopenna.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Message-Id: <200309131256.06501.adasi@kernel.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dnia pi± 12. wrze¶nia 2003 22:55, Marcelo Penna Guerra napisa³:
> Witold Krecicki escreveu:
> > I've lost some of mails about siimage on LKML, but Im' getting more and
> > more confused about 'hangs' probably caused by siimage driver. I was
> > using 15 rqsize, now 128 - doesn't matter. It happens in random moments -
> > sometimes
>
> at
>
> > boot time when drive is fscked, sometimes when I'm trying to copy large
> > amount of data and sometimes without any particular reason after several
> > hours. I've updated MB (a7n8x deluxe rev 2.0) BIOS but controller (which
> > is on-board) bios seems to be untouched (4.1.25 or so ). Is there any
>
> controller
>
> > BIOS update which I could miss? what can be other reason
>
> Do you have APIC enabled? If you enable both ACPI and APIC you'll have
> problems with DMA, using the onboard nForce2 IDE or the SATA chip. I filled
> a bug report and will add some debug info as soon as I recompile my kernel
> with APIC and debug support again.
After disabling APIC in kernel/BIOS it still hanged, but when I've disabled 
ACPI:
 12:55pm  up 13:06,  4 users,  load average: 0.09, 0.03, 0.01
Longest uptime I've ever seen on this HW @ Linux
-- 
Witold Krêcicki (adasi) adasi [at] culm.net
GPG key: 7AE20871
http://www.culm.net
