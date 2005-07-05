Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261896AbVGEVCI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261896AbVGEVCI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 17:02:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261927AbVGEVCG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 17:02:06 -0400
Received: from services106.cs.uwaterloo.ca ([129.97.152.164]:4575 "EHLO
	services106.cs.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S261896AbVGEVBh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 17:01:37 -0400
X-Mailer: emacs 21.4.1 (via feedmail 8 I)
To: David Masover <ninja@slaphack.com>
Cc: Ross Biro <ross.biro@gmail.com>, Horst von Brand <vonbrand@inf.utfsm.cl>,
       Kyle Moffett <mrmacman_g4@mac.com>, Valdis.Kletnieks@vt.edu,
       Lincoln Dale <ltd@cisco.com>, Gregory Maxwell <gmaxwell@gmail.com>,
       Hans Reiser <reiser@namesys.com>, Jeff Garzik <jgarzik@pobox.com>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: reiser4 plugins
From: Hubert Chan <hubert@uhoreg.ca>
In-Reply-To: <42C4F97B.1080803@slaphack.com> (David Masover's message of
 "Fri, 01 Jul 2005 03:06:19 -0500")
References: <hubert@uhoreg.ca>
	<200506290509.j5T595I6010576@laptop11.inf.utfsm.cl>
	<87hdfgvqvl.fsf@evinrude.uhoreg.ca>
	<8783be6605062914341bcff7cb@mail.gmail.com>
	<878y0svj1h.fsf@evinrude.uhoreg.ca> <42C4F97B.1080803@slaphack.com>
X-Hashcash: 1:23:050705:ninja@slaphack.com::lTm5G613uwBGYyYT:0000000000000000000000000000000000000000000Pyu2
X-Hashcash: 1:23:050705:ross.biro@gmail.com::2V712nNGEj1IOjFT:000000000000000000000000000000000000000000TdiD
X-Hashcash: 1:23:050705:vonbrand@inf.utfsm.cl::xJdMlo4nHxjqtncH:0000000000000000000000000000000000000000NTik
X-Hashcash: 1:23:050705:mrmacman_g4@mac.com::fVF/HO/2G8EssHhs:000000000000000000000000000000000000000000GPA6
X-Hashcash: 1:23:050705:valdis.kletnieks@vt.edu::C/7+CiayP+WjABDF:00000000000000000000000000000000000000IUpJ
X-Hashcash: 1:23:050705:ltd@cisco.com::IRLUlQh8Ipc2/yM1:00013lmA
X-Hashcash: 1:23:050705:gmaxwell@gmail.com::L8wYY8c2rNwGuAts:0000000000000000000000000000000000000000000vZv0
X-Hashcash: 1:23:050705:reiser@namesys.com::4GZTSE0dH9hYGk3c:0000000000000000000000000000000000000000000fTJC
X-Hashcash: 1:23:050705:jgarzik@pobox.com::1LnxxpEmTk/bfhXo:00000000000000000000000000000000000000000000fgQQ
X-Hashcash: 1:23:050705:hch@infradead.org::ZxIiXu1UPvoEA8Qc:000000000000000000000000000000000000000000003Rkv
X-Hashcash: 1:23:050705:akpm@osdl.org::w66+i3tF1PutNS4B:00005tcr
X-Hashcash: 1:23:050705:linux-kernel@vger.kernel.org::ZVFbQbs7tazj2wrE:000000000000000000000000000000000OcaU
X-Hashcash: 1:23:050705:reiserfs-list@namesys.com::sf3vJ2MakqLbLBhU:000000000000000000000000000000000000eopO
Date: Tue, 05 Jul 2005 17:01:17 -0400
Message-ID: <87ll4lynky.fsf@evinrude.uhoreg.ca>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (services106.cs.uwaterloo.ca [129.97.152.132]); Tue, 05 Jul 2005 17:01:25 -0400 (EDT)
X-Miltered: at aeacus with ID 42CAF543.000 by Joe's j-chkmail (http://j-chkmail.ensmp.fr)!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 01 Jul 2005 03:06:19 -0500, David Masover <ninja@slaphack.com> said:

> Hubert Chan wrote:

>> The main thing blocking file-as-dir is that there are some
>> locking(IIRC?) issues.  And, of course, some people wouldn't want it
>> to be merged into the mainline kernel.  (Of course, the latter
>> doesn't prevent Namesys from maintaining their own patches for people
>> to play around with.)

> What's the locking issue?  I think that was more about transactions...

It was whatever was Al Viro's (technical) complaint about file-as-dir.
I don't remember exactly what it was.  The technical people know what it
is (and the Namesys guys are probably working on it), and the exact
issue doesn't concern us non-technical people that much, so I don't feel
like looking it up.  But if you want to, just look for Al Viro's message
in this thread.

-- 
Hubert Chan <hubert@uhoreg.ca> - http://www.uhoreg.ca/
PGP/GnuPG key: 1024D/124B61FA
Fingerprint: 96C5 012F 5F74 A5F7 1FF7  5291 AF29 C719 124B 61FA
Key available at wwwkeys.pgp.net.   Encrypted e-mail preferred.

