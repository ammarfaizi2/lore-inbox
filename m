Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262043AbVCaW4u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262043AbVCaW4u (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 17:56:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262044AbVCaW4u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 17:56:50 -0500
Received: from smtpout.mac.com ([17.250.248.88]:3039 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S262043AbVCaWzj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 17:55:39 -0500
In-Reply-To: <Pine.LNX.4.61.0503310706280.8616@chaos.analogic.com>
References: <200503280154.j2S1s9e6009981@laptop11.inf.utfsm.cl> <1112011441.27381.31.camel@localhost.localdomain> <1112016850.6003.13.camel@laptopd505.fenrus.org> <1112018265.27381.63.camel@localhost.localdomain> <20050328154338.753f27e3.pj@engr.sgi.com> <1112055671.3691.8.camel@localhost.localdomain> <c4ce304162b3d2a3ad78dc9e0bc455f5@mac.com> <1112059642.3691.15.camel@localhost.localdomain> <Pine.LNX.4.61.0503290659360.10929@chaos.analogic.com> <Pine.LNX.4.61.0503301446430.30163@chimarrao.boston.redhat.com> <Pine.LNX.4.61.0503301455570.28630@chaos.analogic.com> <3343.10.10.10.24.1112268948.squirrel@linux1.attic.local> <Pine.LNX.4.61.0503310706280.8616@chaos.analogic.com>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <eec4eea446e3ebb8db0a4edbd6a2a41c@mac.com>
Content-Transfer-Encoding: 7bit
Cc: floam@sh.nu, Paul Jackson <pj@engr.sgi.com>, vonbrand@inf.utfsm.cl,
       Steven Rostedt <rostedt@goodmis.org>, Sean <seanlkml@sympatico.ca>,
       gilbertd@treblig.org, bunk@stusta.de,
       LKML <linux-kernel@vger.kernel.org>, arjan@infradead.org,
       Rik van Riel <riel@redhat.com>
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: Can't use SYSFS for "Proprietry" driver modules !!!.
Date: Thu, 31 Mar 2005 17:55:30 -0500
To: linux-os@analogic.com
X-Mailer: Apple Mail (2.619.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mar 31, 2005, at 07:34, linux-os wrote:
> Sure it does. Before the GPL-only stuff the only problem one
> would have with a proprietary module, i.e., one that didn't
> contain the GPL "license" notice, was that the kernel would
> be marked "tainted". Everything would still work.

Wait, you realize that the EXPORT_SYMBOL_GPL vs. EXPORT_SYMBOL
bit doesn't mean a damn thing with respect to the license,
right?  The source code in entirety is licensed under the GPL.
 From my point of view, the _only_ difference between the uses
of the two macros is that the "EXPORT_SYMBOL" macro states
that the developer who last touched that code either:
     o  Has no plans to sue anyone who infringes on their code
     o  Thinks that the interface is so common and so generic
        that a lawsuit would be stupid.
Such a labeling is _only_ a bit of advice and a technical
warning, nothing else.  It can be removed or added without any
issue, as long as you obey the GPL license.  If somebody
disagrees and sues you over it, that's a problem between you
and your lawyers.

> With the ADDITIONAL RESTRICTION added, the module won't even
> work because an ARTIFICIAL CONSTRAINT was added to prevent its
> use unless a GPL "license" notice existed.

Umm, according technically to many interpretations of the GPL,
you can't link anyways unless you're GPL, so such labels are
just advice, and have no major legal bearing.

> [... excess flames snipped ...]

Please cut the worthless rhetoric and irrelevant statements and
either discuss useful information or stop posting.

Cheers,
Kyle Moffett

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCM/CS/IT/U d- s++: a18 C++++>$ UB/L/X/*++++(+)>$ P+++(++++)>$
L++++(+++) E W++(+) N+++(++) o? K? w--- O? M++ V? PS+() PE+(-) Y+
PGP+++ t+(+++) 5 X R? tv-(--) b++++(++) DI+ D+ G e->++++$ h!*()>++$ r  
!y?(-)
------END GEEK CODE BLOCK------


