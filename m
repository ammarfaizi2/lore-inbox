Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265329AbRF0NCX>; Wed, 27 Jun 2001 09:02:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265345AbRF0NCN>; Wed, 27 Jun 2001 09:02:13 -0400
Received: from brule.borg.umn.edu ([160.94.232.10]:4361 "EHLO
	brule.borg.umn.edu") by vger.kernel.org with ESMTP
	id <S265344AbRF0NB7>; Wed, 27 Jun 2001 09:01:59 -0400
From: Peter Bergner <bergner@borg.umn.edu>
Date: Wed, 27 Jun 2001 08:43:55 -0500
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Microsoft and Xenix.
Message-ID: <20010627084355.A57645@brule.borg>
In-Reply-To: <E15DZbq-0008D8-00@roo.home> <01062310075401.00696@localhost.localdomain> <83WVxfbXw-B@khms.westfalen.de> <01062611162702.12583@localhost.localdomain> <20010626172654.B588@munchkin.spectacle-pond.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre2i
In-Reply-To: <20010626172654.B588@munchkin.spectacle-pond.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

First off, my apologies for posting this from my non-work email address.
>From my .sig below, you'll see I work for IBM, Rochester.


Rob Landley wrote:
: The AS400 seems to be based out of Austin.  We hear a lot about it around 
: here...

and...

Michael Meissner wrote:
: Ummm, the AS/400 was based out of Rochester, Minnesota at least initially.
[snip]
: Now that AS/400's are based on special PowerPC's, the home may have moved
: to Austin, which is the PowerPC/AIX center.

The AS/400 (now named iSeries) is and always has been produced in
Rochester Minnesota.  The RS/6000 (now named pSeries) is designed
in Austin.  Both the AS/400 and the RS/6000 are manufactured in
Rochester.  As of some model which escapes me now, both AS/400 and
RS/6000 computers use the *same* PowerPC processor.  The only
difference is that the AS/400 runs the processor in "tags active"
mode (ie, the 65th tag bit enabled).  The first PowerPC processors
used in the AS/400 was designed here in Rochester.  Follow-ons were
designed in Austin.


Kai Henningsen wrote:
: ISTR there's a gcc port for the AS/400.

Due to the fact that the AS/400 has 1 address space shared by all
processes, several restrictions have been implemented.  The main
restriction regarding your statement above is that *all* code that runs
on the AS/400 is compiled by the "trusted" translator (an exception
would be our Java JIT).  This means you cannot create a binary with gcc
and hope to run it on the AS/400.  However, you may use gcc to produce
MI instructions which can then be passed to the trusted translator.



Peter

--
Peter Bergner
SLIC Optimizing Translator Development / Linux PPC64 Kernel Development
IBM Rochester, MN
bergner@us.ibm.com


