Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267599AbTALWyr>; Sun, 12 Jan 2003 17:54:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267607AbTALWyr>; Sun, 12 Jan 2003 17:54:47 -0500
Received: from inet-mail1.oracle.com ([148.87.2.201]:59550 "EHLO
	inet-mail1.oracle.com") by vger.kernel.org with ESMTP
	id <S267599AbTALWyq>; Sun, 12 Jan 2003 17:54:46 -0500
Message-ID: <1755778.1042412319026.JavaMail.nobody@web55.us.oracle.com>
Date: Sun, 12 Jan 2003 14:58:39 -0800 (PST)
From: Alessandro Suardi <ALESSANDRO.SUARDI@oracle.com>
To: valdis.kletnieks@vt.edu, jochen@jochen.org
Subject: Re: [2.5.55, PCI, PCMCIA, XIRCOM] 
Cc: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-Mailer: Oracle Webmail Client
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Fri, 10 Jan 2003 20:00:31 +0100, Jochen Hein said:
> > > - and I've seen a report it causes an OOPS
> > > on 2.5.53.  I've not tried it on post-52, but I had a -54 kernel OOPS

Guess the report was mine :) note for readers, this is bug 134
 in the 2.5 kernel bug database at http://bugme.osdl.org .

> > > right around that point in bootup (right after IDE and somewhere in PCI
> > > init).  Haven't chased that one at all...
> if it OOPSes without my patch, then it's somebody else's problem.  

No, it did oops only with the patch.

[snip]

> In any case, I've attached a new *UNTESTED* patch, that only tries to
> gratuitously
> assign resources of MEM class, and disables the ROM once it does so.
> No, I don't claim to fully understand this code.  And if you're not brave
> enough or can't test it yourself, I'll be taking the 2.5.56 plunge sometime
> this weekend. ;)  And all you other kernel hackers are welcome to jump right
> in and tell me what I'm doing wrong.. ;)

-ENOPATCH ;)


Ciao,

--alessandro
