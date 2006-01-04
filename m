Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751756AbWADLyt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751756AbWADLyt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 06:54:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751758AbWADLyt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 06:54:49 -0500
Received: from mail.shareable.org ([81.29.64.88]:54222 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S1751756AbWADLys
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 06:54:48 -0500
Date: Wed, 4 Jan 2006 11:54:22 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Harald Welte <laforge@gnumonks.org>
Cc: Ben Slusky <sluskyb@paranoiacs.org>, Steven Rostedt <rostedt@goodmis.org>,
       linux-fsdevel@vger.kernel.org, legal@lists.gnumonks.org,
       "Robert W. Fuller" <garbageout@sbcglobal.net>,
       LKML Kernel <linux-kernel@vger.kernel.org>,
       Kyle Moffett <mrmacman_g4@mac.com>, info@crossmeta.com
Subject: Re: blatant GPL violation of ext2 and reiserfs filesystem drivers
Message-ID: <20060104115422.GA2562@mail.shareable.org>
References: <43AACF77.9020206@sbcglobal.net> <496FC071-3999-4E23-B1A2-1503DCAB65C0@mac.com> <1135283241.12761.19.camel@localhost.localdomain> <20051223153541.GA13111@paranoiacs.org> <20060104110929.GH4898@sunbeam.de.gnumonks.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060104110929.GH4898@sunbeam.de.gnumonks.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Harald Welte wrote:
> > The case here appears to be:
> > 
> > * Crossmeta offers "add-on" software as a free download from their web
> >   site: <URL:http://www.crossmeta.com/downloads/crossmeta-add-1_0.zip>.
> >   The zip file contains a text file gpl-license.txt, which says that the
> >   add-ons are offered under the terms of the GPL.
> > 
> > * User downloads this GPLed software and asks the developer to provide
> >   source code. Developer replies that the source code will be provided
> >   only to paying customers:
> >   <URL:http://www.opensolaris.org/jive/message.jspa?messageID=12277#12277>.
> > 
> > That's baad, m'kay?
> 
> This is definitely not acceptable.  A written offer must be valid to ANY
> 3RD PARTY.  
> 
> So it wouldn't even be enough to offer the source code to paying
> customers and those who downloaded the binary code, but actually it must
> be made available to anyone who asks for it.

Ah, that depends on whether they provided the source code for download
to paying customers at the time those customers downloaded the binary.

GPL section 3:
   If distribution of executable or object code is made by offering
   access to copy from a designated place, then offering equivalent
   access to copy the source code from the same place counts as
   distribution of the source code, even though third parties are not
   compelled to copy the source along with the object code.

What this means is that if you make the source code available
alongside the binary, e.g. on a web site under the same conditions of
access, you don't need to provide the written offer to all 3rd
parties; indeed, you don't need to provide the written offer at all.

The above description of what Crossmeta did doesn't clearly say if
Crossmeta provided their customers with the binary and an offer to get
source on request (the written offer), or if those paying customers
were able to download the source at the same time as the binaries.

-- Jamie
