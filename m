Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267386AbTBLSY4>; Wed, 12 Feb 2003 13:24:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267394AbTBLSY4>; Wed, 12 Feb 2003 13:24:56 -0500
Received: from lri.lri.fr ([129.175.15.1]:53204 "EHLO lri.lri.fr")
	by vger.kernel.org with ESMTP id <S267386AbTBLSYz>;
	Wed, 12 Feb 2003 13:24:55 -0500
Message-ID: <3E4A9C4D.F580576E@lri.fr>
Date: Wed, 12 Feb 2003 19:11:09 +0000
From: magniett <Frederic.Magniette@lri.fr>
X-Mailer: Mozilla 4.75 [fr] (X11; U; Linux 2.4.19 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Makan Pourzandi (LMC)" <Makan.Pourzandi@ericsson.ca>
CC: "'Christoph Hellwig'" <hch@infradead.org>,
       "Stephen D. Smalley" <sds@epoch.ncsc.mil>, greg@kroah.com,
       torvalds@transmeta.com, linux-security-module@wirex.com,
       linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] LSM changes for 2.5.59
References: <7B2A7784F4B7F0409947481F3F3FEF8305CC954F@eammlex037.lmc.ericsson.se>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Makan Pourzandi (LMC)" a écrit :

> > > > I'm very serious about submitting a patch to Linus to
> > remove all hooks not
> > > > used by any intree module once 2.6.0-test.
> > >
> > > Any idea on how much time that gives us (to rework SELinux
> > and submit
> > > it)?
> >
>
> Further more, I believe that LSM encourages the developers in the community to take initiatives related to security in Linux. This way, it helps developing different security approaches. This at the end, even if we choose to go with only one approach and drop others,  will help the diversity of existing solutions and the possibility of choosing among a set of solutions (hopefully the best one will be chosen). IMHO, to let people be able to come up with different security approaches, we have
> to let LSM be part of the kernel in order to encourage people to
> develop their approach.
>
> That was my 2 cents.
>
> Regards,
> Makan Pourzandi

Hi,
I'm the leader of a project, developping a sandbox (processes confinement environment) for Linux based on LSM.
Our approach is dedicated for peer-to-peer global computing environments. I totally agree with Makan about the
diversity of developpement : we dont have the same goals than SELinux. The LSM project followed two phases :
in a first one, everybody was thinking about what could be good to integrate in LSM and now (the second phase),
a few people think about what they can remove because they dont use it. We need a flexible and reasonably complete
framework to implement solutions. I recall that it was the original request from Linus : a generic framework to decide
which kind of security solutions are the best. If LSM fits only one or two policy requirements, the choice does not
exist. For finishing : PLEASE, stop reducing LSM possibilities : it cost a lot to develop things for a hook and then
redevelopping it for a classical syscall interposition.
bests
Frédéric Magniette (University of Orsay/CNRS)

