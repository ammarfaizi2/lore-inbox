Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269153AbUJTWaF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269153AbUJTWaF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 18:30:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270563AbUJTWTJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 18:19:09 -0400
Received: from jpnmailout01.yamato.ibm.com ([203.141.80.81]:45964 "EHLO
	jpnmailout01.yamato.ibm.com") by vger.kernel.org with ESMTP
	id S270553AbUJTWQb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 18:16:31 -0400
In-Reply-To: <20041020191531.GC21315@elf.ucw.cz>
Subject: Re: [ACPI] Machines self-power-up with 2.6.9-rc3 (evo N620c, ASUS, ...)
To: Pavel Machek <pavel@ucw.cz>
Cc: ACPI mailing list <acpi-devel@lists.sourceforge.net>,
       acpi-devel-admin@lists.sourceforge.net,
       kernel list <linux-kernel@vger.kernel.org>
X-Mailer: Lotus Notes Release 6.0.2CF2 July 23, 2003
Message-ID: <OF014FB65F.1C41FFC8-ON49256F33.007639BA-49256F33.0079C800@jp.ibm.com>
From: Hiroshi 2 Itoh <HIROIT@jp.ibm.com>
Date: Thu, 21 Oct 2004 07:15:22 +0900
X-MIMETrack: Serialize by Router on D19ML115/19/M/IBM(Release 6.51HF338 | June 21, 2004) at
 2004/10/21 07:15:26
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org





Pavel,

Thanks for your report. I have some suggestions to identify your
problem and help ACPI developers to work more effectively.

The developers are working both fixing ACPI related bugs and applying
work around for bad BIOS behaviors. At this time I think fixing
bugs is more important than applying work around.

So if your problem on some machine is so serious, could you please
give us the BIOS version and whether the machine suspend/resume is
OK in ACPI mode of Windows 2000/XP too? Of course DSDT table check
is highly helpful. http://bugzilla.kernel.org/ is prepared for such
purpose.

I believe such details help the developers to avoid spending much
time to rescue desperate BIOS and to keep tight release schedule.

- Hiro

acpi-devel-admin@lists.sourceforge.net wrote on 2004/10/21 04:15:31:

> Hi!
>
> I'm seeing bad problem with N620c notebook (and have reports of more
> machines behaving like this, for example ASUS L8400C.) If I shutdown
> machine with lid closed, opening lid will power the machine up. Ouch.
> 2.6.7 behaves okay.
>
> Ouch, acpi=off makes it even worse [2.6.9-rc3, N620c]. I get some very
> strange show on the leds (battery charge led blinks fast?!), then
> machine powers up itself. This happens even with lid initially
> open. 2.6.7 works as expected.
>
> Any ideas?
>                         Pavel

