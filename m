Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281643AbRKUHP3>; Wed, 21 Nov 2001 02:15:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281646AbRKUHPS>; Wed, 21 Nov 2001 02:15:18 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:26752 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S281643AbRKUHO5>; Wed, 21 Nov 2001 02:14:57 -0500
Message-ID: <008001c1725c$1bc5cc70$f5976dcf@nwfs>
From: "Jeff Merkey" <jmerkey@timpanogas.org>
To: "David S. Miller" <davem@redhat.com>
Cc: <jmerkey@vger.timpanogas.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <000601c17259$59316630$f5976dcf@nwfs><20011120.225655.85404918.davem@redhat.com><003401c1725a$975ad4e0$f5976dcf@nwfs> <20011120.230914.00464304.davem@redhat.com>
Subject: Re: [VM/MEMORY-SICKNESS] 2.4.15-pre7 kmem_cache_create invalid opcode
Date: Wed, 21 Nov 2001 00:14:07 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> Why does this seem illogical to you?

Philisophical.  Kind of like Linus hating kernel debuggers or something.  If
someone
is building applcations or modules, etc. in a "commerical" software world (I
just opened
the door to get my head bitten off) where I came from, doing stuff like this
was totally
forbidden.  There's a sort of "shell shocked" conditioning folks get into
who have been
in software companies like where I came from where anything that makes it
difficult for
a vendor, partner, developer, etc. to build and maintain code is considered
a serious
defect.

This type of a problem could cause a partner or vendor to spend a lot of
time trying to
figure out what was wrong.  Even more so since the way I stumbled across the
problem
was building a driver on one system with modversions turned off, then
loading the
module on a target system and watching it crash -- very annoying and
wasteful of
time.  It's just a philisophical kind of thing.  i.e. the tools and code
shoudl not have
"easter eggs" hidden in it that make it harder to maintain code.

:-)

Jeff



