Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262898AbREVXwl>; Tue, 22 May 2001 19:52:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262901AbREVXwb>; Tue, 22 May 2001 19:52:31 -0400
Received: from tpau.muc.eurocyber.net ([195.143.108.12]:49937 "EHLO
	tpau.muc.eurocyber.net") by vger.kernel.org with ESMTP
	id <S262898AbREVXwX>; Tue, 22 May 2001 19:52:23 -0400
Message-ID: <3B0AFB50.11996EC5@teraport.de>
Date: Wed, 23 May 2001 01:50:40 +0200
From: Martin Knoblauch <martin.knoblauch@teraport.de>
Organization: Teraport GmbH
X-Mailer: Mozilla 4.6 [en] (X11; I; IRIX 6.5 IP22)
X-Accept-Language: en
MIME-Version: 1.0
To: ttel5535@artax.karlin.mff.cuni.cz
CC: "H. Peter Anvin" <hpa@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [Patch] Output of L1,L2 and L3 cache sizes to /proc/cpuinfo
In-Reply-To: <Pine.LNX.4.21.0105230032440.31122-100000@artax.karlin.mff.cuni.cz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tomas Telensky wrote:
> 
> On 21 May 2001, H. Peter Anvin wrote:
> 
> > Followup to:  <3B090C81.53F163C3@TeraPort.de>
> > By author:    "Martin.Knoblauch" <Martin.Knoblauch@TeraPort.de>
> > In newsgroup: linux.dev.kernel
> > >
> > > Hi,
> > >
> > >  while trying to enhance a small hardware inventory script, I found that
> > > cpuinfo is missing the details of L1, L2 and L3 size, although they may
> > > be available at boot time. One could of cource grep them from "dmesg"
> > > output, but that may scroll away on long lived systems.
> > >
> >
> > Any particular reason this needs to be done in the kernel, as opposed
> 
> It is already done in kernel, because it's displaying :)
> So, once evaluated, why not to give it to /proc/cpuinfo. I think it makes
> sense and gives it things in order.
> 

 That came to my mind as an pro argument also. The work is already done
in setup.c, so why not expose it at the same place where the other stuff
is. After all, it is just a more detailed output of the already
available "cache size" line.

Martin
PS: At least, I am not being ignored :-) No need for me to complain...
