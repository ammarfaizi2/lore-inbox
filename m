Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269349AbTCDJy5>; Tue, 4 Mar 2003 04:54:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269351AbTCDJy5>; Tue, 4 Mar 2003 04:54:57 -0500
Received: from [195.128.145.236] ([195.128.145.236]:11907 "EHLO hippo.ru")
	by vger.kernel.org with ESMTP id <S269349AbTCDJy4>;
	Tue, 4 Mar 2003 04:54:56 -0500
Date: Tue, 4 Mar 2003 15:31:06 +0400
From: Vlad Harchev <hvv@hippo.ru>
To: J?rn Engel <joern@wohnheim.fh-wedel.de>
Cc: Neil Brown <neilb@cse.unsw.edu.au>, linux-kernel@vger.kernel.org
Subject: Re: 2.4 and cryptofs on raid1 - what will be cached and how many times
Message-ID: <20030304113106.GC4024@h>
References: <20030302105634.GA4258@h> <20030303093832.GA4601@h> <15971.52790.676134.722437@notabene.cse.unsw.edu.au> <20030304093020.GA4024@h> <20030304092031.GB6583@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030304092031.GB6583@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 04, 2003 at 10:20:31AM +0100, J?rn Engel wrote:
> On Tue, 4 March 2003 13:30:20 +0400, Vlad Harchev wrote:
> > 
> >  Sorry for confusion - I meant loopback-based crypto filesystem - e.g. loop-aes
> > based (loop-aes.sourceforge.net) or CryptoAPI-based (www.kerneli.org) - both
> > are loopback-based filesystem (one has to call losetup(8) to point out chipher,
> > a password..)
> 
> Loopback with encryption is not the same as a crypto filesystem.
> Loopback encryption works transparently with any (non-)crypto fs.

 Yes, you are right.
 
> A potential attacker can use this to look for the ext2 superblock,
> which gives him the same data both encrypted an unencrypted. A real
 
 I've got an impression that in case of loopback with encryption the 
superblock will also be encrypted. 
 If one forgets known cleartext attacks, one can place the filesystem at
some offset.

> cryptofs would go through great pains to take such advantages away.
> 
-- 
 Best regards,
  -Vlad
