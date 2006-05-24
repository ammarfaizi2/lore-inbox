Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932279AbWEXSzP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932279AbWEXSzP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 14:55:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932405AbWEXSzP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 14:55:15 -0400
Received: from web50105.mail.yahoo.com ([206.190.38.33]:49045 "HELO
	web50105.mail.yahoo.com") by vger.kernel.org with SMTP
	id S932279AbWEXSzN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 14:55:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=bHaRlxs1K1XnEXa3kFPuShj7xYkZkhb80NAa49s8x2WZ+Qq/CIBuCqlSA2dGj2llQhbcuA8QK8LCE+tw6CaxiOZWT4OUPAkQXMsKXbvvvZHNodXJ8QeFIhar1tQTmy1wFUuPrrxU3wcNlXFQpIbGfxiSJ0sZ8DbQIG2FPy00iog=  ;
Message-ID: <20060524185512.99258.qmail@web50105.mail.yahoo.com>
Date: Wed, 24 May 2006 11:55:12 -0700 (PDT)
From: Doug Thompson <norsk5@yahoo.com>
Subject: Re: [PATCH 0/6]  EDAC Patch Set
To: gtm.kramer@inter.nl.net
Cc: Andrew Morton <akpm@osdl.org>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <1148494676.3282.8.camel@paragon.slim>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--- Jurgen Kramer <gtm.kramer@inter.nl.net> wrote:
> 
> Will this patchset fix/suppress the "Non-Fatal Error PCI Express B"
> messages I see with the E7525 edac?

No not yet. These patches are part of the set we gathered in the queue after EDAC
was put into the kernel as a result of various other feedback.  The Non-Fatal noise
has been placed in the queue of work to do. Dave Peterson, who was co-maintainer of
EDAC, has moved on, so I have picking up the TODO slack and flushing these patches
out the door so I can start with a somewhat cleaner slate.

The good news is I have found a maintainer for the E7525 MC driver (I don't have
access to a mobo with that chipset, so I have a problem in verifying any mods I do
work) who has agreed to work with that driver. Thanks to mark gross for taking that
on. He and I have discussed this noise issue.

doug thompson

> 
> I am running 2.6.16 (or more specific FC5 2.6.16-1.2111) with seems to
> already include this version:
> 
> MC: drivers/edac/edac_mc.c version edac_mc  Ver: 2.0.0 May  4 2006
> 
> This version still floods my syslog with "Non-Fatal Error...." messages.
> 
> Jurgen

