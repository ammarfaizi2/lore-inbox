Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261664AbSKCH0G>; Sun, 3 Nov 2002 02:26:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261665AbSKCH0G>; Sun, 3 Nov 2002 02:26:06 -0500
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:38018
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id <S261664AbSKCH0F>; Sun, 3 Nov 2002 02:26:05 -0500
Message-ID: <3DC4D0F1.309@redhat.com>
Date: Sat, 02 Nov 2002 23:32:01 -0800
From: Ulrich Drepper <drepper@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2b) Gecko/20021102
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: phil-list@redhat.com
CC: Mark Gross <markgross@thegnar.org>, Andi Kleen <ak@muc.de>,
       Ingo Molnar <mingo@elte.hu>, Alexander Viro <viro@math.psu.edu>,
       S Vamsikrishna <vamsi_krishna@in.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] thread-aware coredumps, 2.5.43-C3
References: <200210081627.g98GRZP18285@unix-os.sc.intel.com> <200210171835.21647.markgross@thegnar.org> <20021018021242.GA15853@averell> <200210171958.23198.markgross@thegnar.org> <20021021151747.GA227@elf.ucw.cz>
In-Reply-To: <20021021151747.GA227@elf.ucw.cz>
X-Enigmail-Version: 0.65.4.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

>>Having the last branch before a crash would be cool.  Its easy to
>>add note 
> 
> 
> How do you get that info in the first place? I do not think CPU stores
> info about last branch it did...

Haven't seen a reply so far so here it goes.

Look at Intel's System Programming manual for P4.  One of the MSRs
stores this information.  0x1d7 on P4/P4 Xeon.

- -- 
- --------------.                        ,-.            444 Castro Street
Ulrich Drepper \    ,-----------------'   \ Mountain View, CA 94041 USA
Red Hat         `--' drepper at redhat.com `---------------------------
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9xND12ijCOnn/RHQRArenAKCxDdvn7stItfZJaQiAkrgHtf55UQCfTQ/a
Wng6nzdmSip5ZXrN6Mh4Hrs=
=dXdO
-----END PGP SIGNATURE-----

