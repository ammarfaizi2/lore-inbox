Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261782AbVF0DMq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261782AbVF0DMq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Jun 2005 23:12:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261753AbVF0DLp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Jun 2005 23:11:45 -0400
Received: from services106.cs.uwaterloo.ca ([129.97.152.164]:38391 "EHLO
	services106.cs.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S261780AbVF0DLD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Jun 2005 23:11:03 -0400
X-Mailer: emacs 21.4.1 (via feedmail 8 I)
To: Valdis.Kletnieks@vt.edu
Cc: Lincoln Dale <ltd@cisco.com>, Gregory Maxwell <gmaxwell@gmail.com>,
       Hans Reiser <reiser@namesys.com>,
       Horst von Brand <vonbrand@inf.utfsm.cl>,
       Jeff Garzik <jgarzik@pobox.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: reiser4 plugins
From: Hubert Chan <hubert@uhoreg.ca>
In-Reply-To: <200506270040.j5R0eUNA030632@turing-police.cc.vt.edu> (Valdis
 Kletnieks's message of "Sun, 26 Jun 2005 20:40:29 -0400")
References: <200506240241.j5O2f1eb005609@laptop11.inf.utfsm.cl>
	<42BCD93B.7030608@slaphack.com>
	<200506251420.j5PEKce4006891@turing-police.cc.vt.edu>
	<42BDA377.6070303@slaphack.com>
	<200506252031.j5PKVb4Y004482@turing-police.cc.vt.edu>
	<42BDC422.6020401@namesys.com> <42BE3645.4070806@cisco.com>
	<e692861c05062522071fe380a5@mail.gmail.com>
	<42BE563D.4000402@cisco.com> <42BE5DB6.8040103@slaphack.com>
	<200506261816.j5QIGMdI010142@turing-police.cc.vt.edu>
	<42BF08CF.2020703@slaphack.com>
	<200506262105.j5QL5kdR018609@turing-police.cc.vt.edu>
	<42BF2DC4.8030901@slaphack.com>
	<200506270040.j5R0eUNA030632@turing-police.cc.vt.edu>
X-Hashcash: 1:23:050627:valdis.kletnieks@vt.edu::PWzt+d+t17cldTsW:00000000000000000000000000000000000002Fvr6
X-Hashcash: 1:23:050627:ltd@cisco.com::wbTVDfDoyLfTygmf:0000GPqV
X-Hashcash: 1:23:050627:gmaxwell@gmail.com::iv8Pj6OJVvj6tjbW:0000000000000000000000000000000000000000000PBtL
X-Hashcash: 1:23:050627:reiser@namesys.com::EDJRwwrvELc62Q/7:00000000000000000000000000000000000000000021wyC
X-Hashcash: 1:23:050627:vonbrand@inf.utfsm.cl::YlsMY+UeHdQQneHf:0000000000000000000000000000000000000000Q+zt
X-Hashcash: 1:23:050627:jgarzik@pobox.com::+3HCuNm6X8KQ1Xbz:000000000000000000000000000000000000000000002GjZ
X-Hashcash: 1:23:050627:hch@infradead.org::USnx1TyxIyp7jn6E:00000000000000000000000000000000000000000000AFw3
X-Hashcash: 1:23:050627:akpm@osdl.org::OpKQHheOS5XXKQFK:0000Up85
X-Hashcash: 1:23:050627:linux-kernel@vger.kernel.org::tUjjszNnmVcN9bPV:000000000000000000000000000000000U3Xs
X-Hashcash: 1:23:050627:reiserfs-list@namesys.com::/lcmgToDzZrf/3gd:0000000000000000000000000000000000014HRV
Date: Sun, 26 Jun 2005 23:10:43 -0400
Message-ID: <87y88webpo.fsf@evinrude.uhoreg.ca>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Miltered: at rhadamanthus with ID 42BF6E6F.000 by Joe's j-chkmail (http://j-chkmail.ensmp.fr)!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 Jun 2005 20:40:29 -0400, Valdis.Kletnieks@vt.edu said:

> On Sun, 26 Jun 2005 17:35:48 CDT, David Masover said:

>> The kernel does not decide that.  You do.  And it doesn't
>> automatically decide that every time you create a file.  You have to
>> use some interface to trigger the plugins.

> Oh, I'm waiting for the fun the first time somebody deploys a plugin
> that has similar semantics to 'chmod g+s dirname/' ;)

Reiser4 plugins have to be compiled into the kernel.  (They're not
plugins in the sense that most people use that word.)  And any admin who
would compile that kind of plugin into the kernel needs to have his head
examined.  Not to mention that plugins must first go through Hans and/or
Linus before they can get included into the kernel.

The kernel defines the set of plugins available to the user.  The user
selects (to a certain degree) which plugins to use.

-- 
Hubert Chan <hubert@uhoreg.ca> - http://www.uhoreg.ca/
PGP/GnuPG key: 1024D/124B61FA
Fingerprint: 96C5 012F 5F74 A5F7 1FF7  5291 AF29 C719 124B 61FA
Key available at wwwkeys.pgp.net.   Encrypted e-mail preferred.

