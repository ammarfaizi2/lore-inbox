Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266237AbUGATB2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266237AbUGATB2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 15:01:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266241AbUGAS7h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 14:59:37 -0400
Received: from duchamp.tecgraf.puc-rio.br ([139.82.85.1]:35590 "EHLO
	tecgraf.puc-rio.br") by vger.kernel.org with ESMTP id S266227AbUGAS6l
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 14:58:41 -0400
Date: Thu, 1 Jul 2004 16:03:42 -0300
From: Andre Costa <costa@tecgraf.puc-rio.br>
To: "Nick Warne" <nick@ukfsn.org>
Cc: linux-kernel@vger.kernel.org, ballen@gravity.phys.uwm.edu
Subject: Re: 2.4.26: IDE drives become unavailable randomly
Message-Id: <20040701160342.26c557b0.costa@tecgraf.puc-rio.br>
In-Reply-To: <40E4697E.28752.15EB61B8@localhost>
References: <Pine.GSO.4.21.0407010446090.2056-100000@dirac.phys.uwm.edu>
	<40E4697E.28752.15EB61B8@localhost>
Organization: TecGraf
X-Mailer: Sylpheed version 0.9.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(please cc me on any replies, I am not subscribed to this list)

Hi Nick,

On Thu, 01 Jul 2004 19:43:58 +0100
"Nick Warne" <nick@ukfsn.org> wrote:

[snip]
> > Thks, folks, I wouldn't really suspect of bad cables/PSU, this was
> > an eye-opener. I have just opened the box and reseated the 80-wire
> > IDE cable to my hda device, and I will consider replacing it, just
> > in case. The PSU is brand new, 450W -- although it could be bad
> > quality, I will try to check this out.
> > 
> > BTW: Nick, I missed your msg because you didn't cc me. My hda also
> > usually gets disconnected at early hours in the morning, as you
> > pointed out. I arrived today to work and it had happened again =/
> > Last entry on/var/log/messages was around 1:30am, and it was about a
> > NFS mount that had expired.
> > 
> > Best,
> > 
> > Andre
> 
> Hi Andre,
> 
> Sorry, I too am not subscribed to the list, and I read (and reply to) 
> from:
> 
> http://marc.theaimsgroup.com/?l=linux-kernel
> 
> I totally overlooked CC'ing you.

No worries. I have to remind myself over and over again to put the
"please cc me" header on every msg =)

> Anyway, new IDE cable did fix the box at work for me.  Also I only 
> used smartd AFTER the problem arose, not before, so it was not smartd 
> that caused it.

Thks, this is definitely valuable info. I will surely go after some new
cables to see if it improves my situation (I hope it does, otherwise I
will have to move services away from this box and relocate them to other
servers, which will be a PITA...)

On a side note, I browsed 2.4.27rc2 changelogs today, and there is some
interesting stuff there about interruptions, ACPI etc. Looking forward
to trying it out.

Thks again,

Andre

-- 
Andre Oliveira da Costa
(costa@tecgraf.puc-rio.br)
