Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273622AbRJ0R2b>; Sat, 27 Oct 2001 13:28:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273565AbRJ0R2W>; Sat, 27 Oct 2001 13:28:22 -0400
Received: from mout0.freenet.de ([194.97.50.131]:49330 "EHLO mout0.freenet.de")
	by vger.kernel.org with ESMTP id <S273345AbRJ0R2G>;
	Sat, 27 Oct 2001 13:28:06 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Johannes Kloos <j.kloos@gmx.net>
Newsgroups: local.lists.linux-kernel
Subject: Re: strange hangs with kernel 2.4.12 (and 13)
Date: Sat, 27 Oct 2001 17:00:17 +0000 (UTC)
Organization: Pure chaos
Distribution: local
Message-ID: <slrn9tlq11.crb.j.kloos@gandalf.yadha.dnsalias.net>
In-Reply-To: <3BDA8A5E.503EDD28@eunet.at>
NNTP-Posting-Host: localhost.yadha.dnsalias.net
X-Trace: gandalf.yadha.dnsalias.net 1004202017 13164 127.0.0.1 (27 Oct 2001 17:00:17 GMT)
X-Complaints-To: j.kloos@gmx.net
NNTP-Posting-Date: Sat, 27 Oct 2001 17:00:17 +0000 (UTC)
User-Agent: slrn/0.9.7.2 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Reinelt <reinelt@eunet.at> wrote:
> Hi there,
> 
> I've got some strange problems here, since 2.4.12 (2.4.10 was ok, I
> never tried .11)
2.4.10 was the first kernel that broke for me.

> I've got seveal processes hanging in "D" state, especially devfsd. I
> think something with devfs and/or devfsd is broken here. If I kill
> devfsd before, the problem does not arise (but I need devfsd :-)
I've had this problem as well - it seems there's a deadlock in devfs.
I have sent a mail to Richard Gooch about this some days ago, but he
hasn't responded yet.
I will resend my bug report to the list then.

> Now, It gets even more strange: The problem does only exist if I
> deactivate ACPI! I tried with a ACPI enabled kernel with the command
> line "acpi=off", I tried on a machine which is too old for ACPI, and I
> even compiled a kernel without ACPI at all. Everywhere the same problem.
> When I boot with activated ACPI, there's no problem.
I don't know about this.

> Any hints? If someone could tell me what I should try or which debug
> info could be useful, please let me know!
> 
> TIA, Michael
> 


-- 
Johannes Kloos
"Walk a mile on these paws and call me a liar."
-- Gaspode the wonder dog (Terry Pratchett, Moving Pictures)
