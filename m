Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317572AbSG2Rpv>; Mon, 29 Jul 2002 13:45:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317570AbSG2Roq>; Mon, 29 Jul 2002 13:44:46 -0400
Received: from [195.39.17.254] ([195.39.17.254]:15232 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S317566AbSG2Rns>;
	Mon, 29 Jul 2002 13:43:48 -0400
Date: Mon, 29 Jul 2002 18:39:38 +0000
From: Pavel Machek <pavel@suse.cz>
To: Christoph Hellwig <hch@infradead.org>,
       Dave Kleikamp <shaggy@austin.ibm.com>, axel@hh59.org,
       linux-kernel@vger.kernel.org, jfs-discussion@oss.software.ibm.com
Subject: Re: [Jfs-discussion] Re: 2.5.27: Software Suspend failure / JFS errors
Message-ID: <20020729183937.D38@toy.ucw.cz>
References: <20020721122932.GA23552@neon.hh59.org> <20020721144212.GA23767@neon.hh59.org> <200207230954.36039.shaggy@austin.ibm.com> <20020723160657.A23708@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20020723160657.A23708@infradead.org>; from hch@infradead.org on Tue, Jul 23, 2002 at 04:06:57PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > This oops occurred during build of gcc..
> > > Kernel 2.4.19-rc2-ac2.
> > > About the same happens with 2.5.27. I will post an oops of jfsCommit
> > > of 2.5.27 as soon as I get one.
> > 
> > I just built gcc on 2.4.19-rc3 + latest JFS and didn't have a problem.  
> > I'll repeat it on 2.4.19-rc2-ac2, but there shouldn't be more than a 
> > comsmetic difference in the JFS code.  I haven't tried 2.5.27 yet.
> 
> As I read 'Software Suspend' in the subject I guess it's swsusp fault.
> Swsusp needs magic flags for kernel threads which no one has added to
> JFS yet.

Hehe. Really someone should add if (current->flags & PF_FREEZE) refrigerator(); 
at the right place of JFS threads. I don't have JFS installed so it is hard
for me to do that, sorry.
								Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

