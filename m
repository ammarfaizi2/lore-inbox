Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265323AbSJXGGo>; Thu, 24 Oct 2002 02:06:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265325AbSJXGGo>; Thu, 24 Oct 2002 02:06:44 -0400
Received: from smtp.actcom.co.il ([192.114.47.13]:63365 "EHLO
	lmail.actcom.co.il") by vger.kernel.org with ESMTP
	id <S265323AbSJXGGn>; Thu, 24 Oct 2002 02:06:43 -0400
Subject: Re: One for the Security Guru's
From: Gilad Ben-Yossef <gilad@benyossef.com>
To: James Stevenson <james@stev.org>
Cc: jamesclv@us.ibm.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1035411422.5377.11.camel@god.stev.org>
References: <20021023130251.GF25422@rdlg.net>
	<1035380716.4323.50.camel@irongate.swansea.linux.org.uk>
	<1035381547.4182.65.camel@klendathu.telaviv.sgi.com> 
	<200210231514.07192.jamesclv@us.ibm.com> 
	<1035411422.5377.11.camel@god.stev.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 24 Oct 2002 08:12:44 +0200
Message-Id: <1035439965.9144.19.camel@gby.benyossef.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-10-24 at 00:17, James Stevenson wrote:
> 
> > Be surprised:  I run "gpg --verify foo.tgz.sign foo.tgz" every time I download 
> > from kernel.org.  And, "rpm --checksig *.rpm" on stuff from redhat.com too.
> 
> and when an attacker looks into your .bash_history see this and modifies
> gpg and rpm ?

When the attacker can look into the .bash_history of root he has already
taken over the box. As Alan already stated before on this thread, when
the attacker has root, the game is over anyway - what happens next only
effects how long it will take you to find out you have 'guests'.

The purpose of the GPG spiel is to stop (read: make it harder) from the
attacker becoming root in the first place, for example by replacing
packages you download (either on the ftp site or in trnasit) with
trojaned copies. 

Gilad.
-- 
Gilad Ben-Yossef <gilad@benyossef.com>
http://benyossef.com

 "Geeks rock bands cool name #8192: RAID against the machine"

