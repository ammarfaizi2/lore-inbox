Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262616AbRFTVR2>; Wed, 20 Jun 2001 17:17:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263244AbRFTVRS>; Wed, 20 Jun 2001 17:17:18 -0400
Received: from 216-99-213-120.dsl.aracnet.com ([216.99.213.120]:52234 "HELO
	clueserver.org") by vger.kernel.org with SMTP id <S262616AbRFTVRL>;
	Wed, 20 Jun 2001 17:17:11 -0400
Date: Wed, 20 Jun 2001 15:28:31 -0700 (PDT)
From: Alan Olsen <alan@clueserver.org>
To: linux-kernel@vger.kernel.org
Cc: jjciarla@raiz.uncu.edu.ar, schoenfr@gaertner.DE
Subject: IP_ALIAS in 2.4.x gone?
In-Reply-To: <993069751.10191.0.camel@agate>
Message-ID: <Pine.LNX.4.10.10106201516470.12664-100000@clueserver.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Has the IP_ALIAS functionality been replaced by something else in the
2.4.x kernels?

Documentation/networking/alias.txt seems to imply that it still does, but
the string IP_ALIAS does not exist anywhere else in the entire source
tree. (Unless you count the default configs for non-i86 architectures.

There is a "virtual server" option in the kernel that ships with Redhat,
but I assume that this is a patch for something Redhat specific.  (It is
not an option in 2.4.5, unless I am missing something.)

How is binding multiple IPs to a single ethernet card *supposed* to be
handled under 2.4.x?  If the IP_ALIAS option is no longer valid, then the
alias.txt doc should be changed to reflect the new option.

Thanks!

alan@ctrl-alt-del.com | Note to AOL users: for a quick shortcut to reply
Alan Olsen            | to my mail, just hit the ctrl, alt and del keys.
 "All power is derived from the barrel of a gnu." - Mao Tse Stallman

