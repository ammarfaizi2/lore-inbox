Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262802AbVF3Edf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262802AbVF3Edf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 00:33:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262808AbVF3Edb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 00:33:31 -0400
Received: from services106.cs.uwaterloo.ca ([129.97.152.164]:25539 "EHLO
	services106.cs.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S262802AbVF3Ed1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 00:33:27 -0400
X-Mailer: emacs 21.4.1 (via feedmail 8 I)
To: Hans Reiser <reiser@namesys.com>
Cc: Horst von Brand <vonbrand@inf.utfsm.cl>,
       Kyle Moffett <mrmacman_g4@mac.com>, David Masover <ninja@slaphack.com>,
       Valdis.Kletnieks@vt.edu, Lincoln Dale <ltd@cisco.com>,
       Gregory Maxwell <gmaxwell@gmail.com>, Jeff Garzik <jgarzik@pobox.com>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: reiser4 plugins
From: Hubert Chan <hubert@uhoreg.ca>
In-Reply-To: <42C3615A.9020600@namesys.com> (Hans Reiser's message of "Wed,
 29 Jun 2005 20:04:58 -0700")
References: <hubert@uhoreg.ca>
	<200506290509.j5T595I6010576@laptop11.inf.utfsm.cl>
	<87hdfgvqvl.fsf@evinrude.uhoreg.ca>
	<8783be6605062914341bcff7cb@mail.gmail.com>
	<42C3615A.9020600@namesys.com>
X-Hashcash: 1:23:050630:reiser@namesys.com::Gk4MSeaYIyjqKBJB:0000000000000000000000000000000000000000000XBU1
X-Hashcash: 1:23:050630:vonbrand@inf.utfsm.cl::JezaYEbKEsOON5cB:0000000000000000000000000000000000000000rDB+
X-Hashcash: 1:23:050630:mrmacman_g4@mac.com::WdTEI0tkqjwLzC6T:000000000000000000000000000000000000000000BhnE
X-Hashcash: 1:23:050630:ninja@slaphack.com::5MP38ms5fvqD+tlh:0000000000000000000000000000000000000000000WiQY
X-Hashcash: 1:23:050630:valdis.kletnieks@vt.edu::oMKuPF1bbjIgQbak:000000000000000000000000000000000000006TbX
X-Hashcash: 1:23:050630:ltd@cisco.com::KsdF/VVo2QduOroP:00011kMd
X-Hashcash: 1:23:050630:gmaxwell@gmail.com::4hRWRd6JqoRVseKC:0000000000000000000000000000000000000000000knrZ
X-Hashcash: 1:23:050630:jgarzik@pobox.com::BAqtjXIkKn/lhNL6:00000000000000000000000000000000000000000000KYQ0
X-Hashcash: 1:23:050630:hch@infradead.org::Qcrk949HNsErI0aa:0000000000000000000000000000000000000000000041C5
X-Hashcash: 1:23:050630:akpm@osdl.org::Lomg6DC2Eqa5cIEo:0000AZOn
X-Hashcash: 1:23:050630:linux-kernel@vger.kernel.org::MqGUFro2IbBcULZQ:00000000000000000000000000000000098Yv
X-Hashcash: 1:23:050630:reiserfs-list@namesys.com::CG2HFiVT0hSUu523:0000000000000000000000000000000000006/7/
Date: Thu, 30 Jun 2005 00:33:10 -0400
Message-ID: <871x6kv4zd.fsf@evinrude.uhoreg.ca>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Miltered: at rhadamanthus with ID 42C37647.004 by Joe's j-chkmail (http://j-chkmail.ensmp.fr)!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Jun 2005 20:04:58 -0700, Hans Reiser <reiser@namesys.com> said:

> Ross Biro wrote:
>> How is directories as files logically any different than putting all
>> data into .data files and making all files directories (yes you would
>> need some sort of special handling for files that were really called
>> .data).

> Add to this that you make .data the default if the file within the
> directory is not specified,

It's sort of like the way web servers handle index.html, for those who
think it's a stupid idea.  (Of course, some people may still think it's
a stupid idea... ;-) )

> and define a stanadard set of names for metafiles, and you've got the
> essential idea, and any differences are details.

-- 
Hubert Chan <hubert@uhoreg.ca> - http://www.uhoreg.ca/
PGP/GnuPG key: 1024D/124B61FA
Fingerprint: 96C5 012F 5F74 A5F7 1FF7  5291 AF29 C719 124B 61FA
Key available at wwwkeys.pgp.net.   Encrypted e-mail preferred.

