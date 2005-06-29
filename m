Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262644AbVF2VAU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262644AbVF2VAU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 17:00:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262650AbVF2U7L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 16:59:11 -0400
Received: from services106.cs.uwaterloo.ca ([129.97.152.164]:28150 "EHLO
	services106.cs.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S262646AbVF2U6R convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 16:58:17 -0400
X-Mailer: emacs 21.4.1 (via feedmail 8 I)
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: Douglas McNaught <doug@mcnaught.org>, Kyle Moffett <mrmacman_g4@mac.com>,
       David Masover <ninja@slaphack.com>, Valdis.Kletnieks@vt.edu,
       Lincoln Dale <ltd@cisco.com>, Gregory Maxwell <gmaxwell@gmail.com>,
       Hans Reiser <reiser@namesys.com>, Jeff Garzik <jgarzik@pobox.com>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: reiser4 plugins
From: Hubert Chan <hubert@uhoreg.ca>
In-Reply-To: <200506291719.j5THJCSg011438@laptop11.inf.utfsm.cl> (Horst von
 Brand's message of "Wed, 29 Jun 2005 13:19:12 -0400")
References: <20050629135820.GJ11013@nysv.org>
	<200506291719.j5THJCSg011438@laptop11.inf.utfsm.cl>
X-Hashcash: 1:23:050629:vonbrand@inf.utfsm.cl::8eqeDYQdZXafYJUR:0000000000000000000000000000000000000000zLte
X-Hashcash: 1:23:050629:doug@mcnaught.org::isLvV7dG98cwU1lC:00000000000000000000000000000000000000000000ItDY
X-Hashcash: 1:23:050629:mrmacman_g4@mac.com::qdoE/pHc+pgSYzax:0000000000000000000000000000000000000000007csh
X-Hashcash: 1:23:050629:ninja@slaphack.com::UkFs7n7PBJkV5jO3:0000000000000000000000000000000000000000000N8CB
X-Hashcash: 1:23:050629:valdis.kletnieks@vt.edu::VUhskq+Pggtg1q9c:00000000000000000000000000000000000000f0g+
X-Hashcash: 1:23:050629:ltd@cisco.com::9ySzpuKsKNgEVq4q:0000ZsvO
X-Hashcash: 1:23:050629:gmaxwell@gmail.com::NU65i7k7AKaAk20n:0000000000000000000000000000000000000000000I9cc
X-Hashcash: 1:23:050629:reiser@namesys.com::jJD9OdpT18hUcd1p:0000000000000000000000000000000000000000000CURZ
X-Hashcash: 1:23:050629:jgarzik@pobox.com::+lFkMsvSC+vhJpij:00000000000000000000000000000000000000000000EOzT
X-Hashcash: 1:23:050629:hch@infradead.org::XY+6NZR4o0PR2CF+:000000000000000000000000000000000000000000007Cd3
X-Hashcash: 1:23:050629:akpm@osdl.org::P6BSKs66QImRXSrk:0000B8qO
X-Hashcash: 1:23:050629:linux-kernel@vger.kernel.org::UwaC6Rn2YBCha1JV:000000000000000000000000000000000CM+p
X-Hashcash: 1:23:050629:reiserfs-list@namesys.com::pHYv3E2t3jsMA/72:0000000000000000000000000000000000002lW1
Date: Wed, 29 Jun 2005 16:57:56 -0400
Message-ID: <87d5q4vq23.fsf@evinrude.uhoreg.ca>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=utf-8
X-Miltered: at rhadamanthus with ID 42C30B92.002 by Joe's j-chkmail (http://j-chkmail.ensmp.fr)!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Jun 2005 13:19:12 -0400, Horst von Brand <vonbrand@inf.utfsm.cl> said:

> Markus Törnqvist <mjt@nysv.org> wrote: [...]

>> Note that MacOS has the monopoly on what they ship, Linux has a
>> motherload of file managers and window systems and all.

> Yep. Part of what is nice about it, too ;-)

I guess that's why Apple doesn't want to make its X11 support too good.
Otherwise the Mac world would get flooded with X11 programs that don't
work the same way as the rest of the Mac programs.

>> What pisses me off is the fact that Gnome and friends implement their
>> own incompatible-with-others VFS's and automounters and stuff.

> Then get them to agree on a common framework! They are trying hard to
> get other parts of the GUI work well together, so this isn't far off
> in wishfull thinking land.

I honestly hope you're right.  The more cooperation we have between
GNOME and KDE and everyone else, the better.

>> Surely supporting this in the kernel and extending the LSB to require
>> this is the best step to take without infringing anyone's freedom as
>> such.

> Right. So then we have Gnome's way of doing things (Gnome isn't just
> for Linux!), KDE's way, XFCE's way, ... (ditto). Plus the kernel
> way. Flambee with a monthly thread on all reachable fora about "Why on
> &%@# does the %&~#@ GUI not use the *#%&@ kernel's way?!".

GNOME has HAL, their hardware abstraction layer, which uses (I assume)
the kernel's facility to interact with the hardware.  If someone ports
GNOME to Windows, then HAL would use the Windows way to interact with
the hardware.  I can't see why it can't do something similar with the
filesystem.  Because who knows, maybe Gnumeric will need to access
substream data under Windows to open an Excel file properly.  Or
Nautilus may have to read ... OS/2 extended attributes :-/

-- 
Hubert Chan <hubert@uhoreg.ca> - http://www.uhoreg.ca/
PGP/GnuPG key: 1024D/124B61FA
Fingerprint: 96C5 012F 5F74 A5F7 1FF7  5291 AF29 C719 124B 61FA
Key available at wwwkeys.pgp.net.   Encrypted e-mail preferred.

