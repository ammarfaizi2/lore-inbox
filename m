Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261533AbUL3Evr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261533AbUL3Evr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Dec 2004 23:51:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261535AbUL3Evr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Dec 2004 23:51:47 -0500
Received: from fw.osdl.org ([65.172.181.6]:24241 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261533AbUL3Evq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Dec 2004 23:51:46 -0500
Date: Wed, 29 Dec 2004 20:51:22 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Davide Libenzi <davidel@xmailserver.org>
cc: Jesse Allen <the3dfxdude@gmail.com>, Mike Hearn <mh@codeweavers.com>,
       Thomas Sailer <sailer@scs.ch>, Eric Pouech <pouech-eric@wanadoo.fr>,
       Daniel Jacobowitz <dan@debian.org>, Roland McGrath <roland@redhat.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, wine-devel <wine-devel@winehq.com>
Subject: Re: ptrace single-stepping change breaks Wine
In-Reply-To: <Pine.LNX.4.58.0412291745470.2353@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.58.0412292050550.22893@ppc970.osdl.org>
References: <200411152253.iAFMr8JL030601@magilla.sf.frob.com> 
 <20041120214915.GA6100@tesore.ph.cox.net>  <41A251A6.2030205@wanadoo.fr> 
 <Pine.LNX.4.58.0411221300460.20993@ppc970.osdl.org>  <1101161953.13273.7.camel@littlegreen>
  <1104286459.7640.54.camel@gamecube.scs.ch>  <1104332559.3393.16.camel@littlegreen>
  <Pine.LNX.4.58.0412291047120.2353@ppc970.osdl.org> 
 <53046857041229114077eb4d1d@mail.gmail.com>  <Pine.LNX.4.58.0412291151080.2353@ppc970.osdl.org>
 <530468570412291343d1478cf@mail.gmail.com> <Pine.LNX.4.58.0412291622560.2353@ppc970.osdl.org>
 <Pine.LNX.4.58.0412291703400.30636@bigblue.dev.mdolabs.com>
 <Pine.LNX.4.58.0412291745470.2353@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 29 Dec 2004, Linus Torvalds wrote:
> 
> So the updated patch would look something like the appended.

.. no, I see what's up. System call returns _are_ special for 
single-stepping. I'll think about it..

		Linus
