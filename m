Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278592AbRJ1RcS>; Sun, 28 Oct 2001 12:32:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278604AbRJ1RcJ>; Sun, 28 Oct 2001 12:32:09 -0500
Received: from smtp.austria.eu.net ([193.81.83.3]:39149 "EHLO
	hausmasta.austria.eu.net") by vger.kernel.org with ESMTP
	id <S278592AbRJ1Rb4>; Sun, 28 Oct 2001 12:31:56 -0500
Message-ID: <3BDC412E.88A77A4A@eunet.at>
Date: Sun, 28 Oct 2001 18:32:30 +0100
From: Michael Reinelt <reinelt@eunet.at>
Organization: netWorks
X-Mailer: Mozilla 4.77 [de] (X11; U; Linux 2.4.10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: strange hangs with kernel 2.4.12 (and 13)
In-Reply-To: <3BDA8A5E.503EDD28@eunet.at> <slrn9tlq11.crb.j.kloos@gandalf.yadha.dnsalias.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-AntiVirus: OK (checked by AntiVir Version 6.10.0.20)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Johannes Kloos wrote:
> 
> Michael Reinelt <reinelt@eunet.at> wrote:
> > I've got seveal processes hanging in "D" state, especially devfsd. I
> > think something with devfs and/or devfsd is broken here. If I kill
> > devfsd before, the problem does not arise (but I need devfsd :-)
> I've had this problem as well - it seems there's a deadlock in devfs.
> I have sent a mail to Richard Gooch about this some days ago, but he
> hasn't responded yet.
> I will resend my bug report to the list then.
Mybe you could CC me the reports? I'm not a regular reader of lkml.
Thanks...

> > Now, It gets even more strange: The problem does only exist if I
> > deactivate ACPI! I tried with a ACPI enabled kernel with the command
> > line "acpi=off", I tried on a machine which is too old for ACPI, and I
> > even compiled a kernel without ACPI at all. Everywhere the same problem.
> > When I boot with activated ACPI, there's no problem.
> I don't know about this.
Well, I've just had the same problem with ACPI. So forget about the last
paragraph.

But I found another strange thing: If I deactivate nscd, the problem
does not occur when logging in and out.

bye, Michael

-- 
netWorks                                          Vox: +43 316  698260
Michael Reinelt                                   Fax: +43 316  692343
Geisslergasse 4                                   GSM: +43 676 3079941
A-8045 Graz, Austria                          e-mail: reinelt@eunet.at
