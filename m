Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135396AbREHVEv>; Tue, 8 May 2001 17:04:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135380AbREHVEl>; Tue, 8 May 2001 17:04:41 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:41231 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S135396AbREHVE3>;
	Tue, 8 May 2001 17:04:29 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200105082104.f48L4FJ132293@saturn.cs.uml.edu>
Subject: Re: OT: ps source?
To: pierre.rousselet@wanadoo.fr (Pierre Rousselet)
Date: Tue, 8 May 2001 17:04:15 -0400 (EDT)
Cc: jbourne@MtRoyal.AB.CA (James Bourne), fred4160@yahoo.com (Fred Fleck),
        linux-kernel@vger.kernel.org
In-Reply-To: <3AF7A005.4EA9E37A@wanadoo.fr> from "Pierre Rousselet" at May 08, 2001 09:28:05 AM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pierre Rousselet writes:
> James Bourne wrote:

>> From the procps man page:
>>        Albert Cahalan <acahalan@cs.uml.edu> rewrote ps  for  full
>>        Unix98  and  BSD  support,  along with some ugly hacks for
>>        obsolete and foreign syntax.
>> 
>>        Michael K. Johnson <johnsonm@redhat.com>  is  the  current
>>        maintainer.

There has been a bit of a fork actually... sorry.

> Right. For international support procps-2.0.7 is the one to choose with
> the patch procps-2.0.7-intl.patch.

That one is quite buggy. The parser is broken ("ps -o %p" fails),
you can get a core dump if you get unlucky with the System.map file,
the BSD-style process selection is incorrect... I've fixed about 100
bugs and introduced only a few.

What you really ought to use is the Debian package. That gives you
my source plus a few fixes that I don't have yet. Head over to
www.debian.org and drill down to the "unstable" package. There you
will find a source tarball and a patch file for it.

