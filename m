Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318401AbSGSARA>; Thu, 18 Jul 2002 20:17:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318404AbSGSARA>; Thu, 18 Jul 2002 20:17:00 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:18053 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S318401AbSGSARA>; Thu, 18 Jul 2002 20:17:00 -0400
Date: Thu, 18 Jul 2002 18:19:53 -0600
Message-Id: <200207190019.g6J0JrM28129@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Alexander Viro <viro@math.psu.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Rusty's module talk at the Kernel Summit 
In-Reply-To: <Pine.GSO.4.21.0207110155330.6250-100000@weyl.math.psu.edu>
References: <20020711051232.5F93844F8@lists.samba.org>
	<Pine.GSO.4.21.0207110155330.6250-100000@weyl.math.psu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro writes:
> Call them well-behaving modules if you wish.  For these the answers
> are "yes"/"a lot of things can be"/"it's easy to handle".  What's
> left?  The pieces of code with really complex interfaces.  And guess
> what, race-prevention is complex for these guys - and it's not just
> about rmmod races.  E.g. parts of procfs, sysctls and devfs are
> still quite racy even if you compile everything into the tree and
> remove all module-related syscalls completely.

Can you point to specific problems with the current devfs code?

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
