Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265247AbTFMIOO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 04:14:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265248AbTFMION
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 04:14:13 -0400
Received: from verdi.et.tudelft.nl ([130.161.38.158]:640 "EHLO
	verdi.et.tudelft.nl") by vger.kernel.org with ESMTP id S265247AbTFMIOK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 04:14:10 -0400
Message-Id: <200306130827.h5D8RrJ5004185@verdi.et.tudelft.nl>
X-Mailer: exmh version 2.5 01/15/2001 with nmh-1.0.4
X-Exmh-Isig-CompType: repl
X-Exmh-Isig-Folder: linux-kernel
To: Arjan van de Ven <arjanv@redhat.com>
cc: Rob van Nieuwkerk <robn@verdi.et.tudelft.nl>,
       Andries Brouwer <aebr@win.tue.nl>, Alan Cox <alan@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: open(.. O_DIRECT ..) difference in between Linux and FreeBSD .. 
In-Reply-To: Message from Arjan van de Ven <arjanv@redhat.com> 
   of "Fri, 13 Jun 2003 07:47:02 -0000." <20030613074702.B30329@devserv.devel.redhat.com> 
Mime-Version: 1.0
Content-Type: text/plain
Date: Fri, 13 Jun 2003 10:27:52 +0200
From: Rob van Nieuwkerk <robn@verdi.et.tudelft.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Arjan van de Ven wrote:
> On Fri, Jun 13, 2003 at 01:12:57AM +0200, Rob van Nieuwkerk wrote:
> > FYI:
> > It appears that somewhere between RH kernels 2.4.18-27.7.x and 2.4.20-18.9
> > something has changed so that my application needs a O_SYNC too besides
> > the O_DIRECT to make sure that writes will be synchronous.  If I leave
> > the O_SYNC out with 2.4.20-18.9 the write will happen physically 35
> > seconds after the write() was done.
> 
> O_DIRECT is nothing but a hint and the 2.4.20-18.9 kernel decides to not
> honor it

Hi Arjan,

Do you mean that the 2.4.20-18.9 kernel always ignores the O_DIRECT flag ?

	greetings,
	Rob van Nieuwkerk
