Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261206AbVF1T6q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261206AbVF1T6q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 15:58:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261248AbVF1T6k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 15:58:40 -0400
Received: from services106.cs.uwaterloo.ca ([129.97.152.164]:17146 "EHLO
	services106.cs.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S261261AbVF1T5w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 15:57:52 -0400
X-Mailer: emacs 21.4.1 (via feedmail 8 I)
To: David Masover <ninja@slaphack.com>
Cc: Kyle Moffett <mrmacman_g4@mac.com>, Valdis.Kletnieks@vt.edu,
       Lincoln Dale <ltd@cisco.com>, Gregory Maxwell <gmaxwell@gmail.com>,
       Hans Reiser <reiser@namesys.com>,
       Horst von Brand <vonbrand@inf.utfsm.cl>,
       Jeff Garzik <jgarzik@pobox.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: reiser4 plugins
From: Hubert Chan <hubert@uhoreg.ca>
In-Reply-To: <42C1A5E8.2040603@slaphack.com> (David Masover's message of
 "Tue, 28 Jun 2005 14:32:56 -0500")
References: <200506240241.j5O2f1eb005609@laptop11.inf.utfsm.cl>
	<200506261816.j5QIGMdI010142@turing-police.cc.vt.edu>
	<42BF08CF.2020703@slaphack.com>
	<200506262105.j5QL5kdR018609@turing-police.cc.vt.edu>
	<42BF2DC4.8030901@slaphack.com>
	<200506270040.j5R0eUNA030632@turing-police.cc.vt.edu>
	<42BF667C.50606@slaphack.com>
	<5284F665-873C-45B7-8DDB-5F475F2CE399@mac.com>
	<42BF7167.80201@slaphack.com>
	<EC02A684-815A-4DF8-B5C1-9029FE45E187@mac.com>
	<42C06D59.2090200@slaphack.com>
	<CD59AE36-FD15-4A4C-9E1D-AB2F8B52D653@mac.com>
	<42C08B5E.2080000@slaphack.com> <87y88vrzkg.fsf@evinrude.uhoreg.ca>
	<EBD8F590-0113-4509-9604-E6967C65C835@mac.com>
	<87mzpbrvpf.fsf@evinrude.uhoreg.ca>
	<D3A4ABBF-8062-4399-B1EC-61722295944A@mac.com>
	<87irzzrqu7.fsf@evinrude.uhoreg.ca>
	<2B1C058D-C304-4E15-ACDA-C3337E67E981@mac.com>
	<87d5q6pdyv.fsf@evinrude.uhoreg.ca> <42C1A5E8.2040603@slaphack.com>
X-Hashcash: 1:23:050628:ninja@slaphack.com::FN4vd7tZ9Jb8e3NN:00000000000000000000000000000000000000000002Gb+
X-Hashcash: 1:23:050628:mrmacman_g4@mac.com::RIZjCB5pEjs6UcJr:0000000000000000000000000000000000000000009g2t
X-Hashcash: 1:23:050628:valdis.kletnieks@vt.edu::2AHmJZOHmEMAEbFT:00000000000000000000000000000000000000mhtK
X-Hashcash: 1:23:050628:ltd@cisco.com::VkpN1tpVcHPH4hZX:0000Ct+n
X-Hashcash: 1:23:050628:gmaxwell@gmail.com::dxGnpAk4pUKBGF/e:00000000000000000000000000000000000000000003RWG
X-Hashcash: 1:23:050628:reiser@namesys.com::EPlpUMnH9iR+diJP:0000000000000000000000000000000000000000000Hp6G
X-Hashcash: 1:23:050628:vonbrand@inf.utfsm.cl::Q2CgEr7Jc8+xXNaO:0000000000000000000000000000000000000000utyM
X-Hashcash: 1:23:050628:jgarzik@pobox.com::t8UBtLw4p7C+3AVS:000000000000000000000000000000000000000000002YI+
X-Hashcash: 1:23:050628:hch@infradead.org::mb1do0lAEIblwlFP:00000000000000000000000000000000000000000000JclU
X-Hashcash: 1:23:050628:akpm@osdl.org::/eHzBdZAVva3vUem:0000C0WG
X-Hashcash: 1:23:050628:linux-kernel@vger.kernel.org::Tpj06pMdqb4EntG5:0000000000000000000000000000000009gUy
X-Hashcash: 1:23:050628:reiserfs-list@namesys.com::YLHqAL3jS2nDCWVn:0000000000000000000000000000000000007CRv
Date: Tue, 28 Jun 2005 15:57:35 -0400
Message-ID: <87mzpantjk.fsf@evinrude.uhoreg.ca>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Miltered: at persephone with ID 42C1AB89.000 by Joe's j-chkmail (http://j-chkmail.ensmp.fr)!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Jun 2005 14:32:56 -0500, David Masover <ninja@slaphack.com> said:

> Hubert Chan wrote:
>> On Tue, 28 Jun 2005 02:01:12 -0400, Kyle Moffett
>> <mrmacman_g4@mac.com> said:

>>> I don't deny them the right to add other interfaces later, but such
>>> should be a secondary or tertiary patch, after the rest of the stuff
>>> is in.  In any case, if we were to provide an interface by which one
>>> could $EDITOR the POSIX ACLs, it should be done in the VFS where all
>>> filesystems can share it.

>> I don't know if VFS is the right place for it, but I agree that it
>> would be good to make it accessible to all filesystems.

Sorry, "accessible to all filesystems" is incorrect terminology (it's
backwards).  What I meant was something more like "able to access
extended data from all filesystems".  But I think everyone understands
what I meant.

> You put it in /meta, which is available to all filesystems.

>> Looking forward to the flamewar that happens when Namesys decides
>> that file-as-dir is ready to be turned on again. ;-)

> Namesys still hasn't commented directly on the /meta proposal, have
> they?  That would avoid the flamewar altogether.

Well, we could still have a flamewar about whether metafs is useful,
what type of functionality it should provide, etc.  I'm sure we could
find something to argue about. ;-)

>From a purely philosophical/aesthetic/theoretical point of view, I like
file-as-dir much better than anything else, and would be ecstatic it if
Namesys was able to make it work.  From a practical/technical point of
view, metafs may be an acceptable compromise.

-- 
Hubert Chan <hubert@uhoreg.ca> - http://www.uhoreg.ca/
PGP/GnuPG key: 1024D/124B61FA
Fingerprint: 96C5 012F 5F74 A5F7 1FF7  5291 AF29 C719 124B 61FA
Key available at wwwkeys.pgp.net.   Encrypted e-mail preferred.

