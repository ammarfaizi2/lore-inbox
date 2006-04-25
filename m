Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932208AbWDYMWj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932208AbWDYMWj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 08:22:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932209AbWDYMWj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 08:22:39 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:36606 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP id S932208AbWDYMWi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 08:22:38 -0400
In-Reply-To: <1145950336.11463.8.camel@localhost>
Subject: Re: [PATCH/RFC] s390: Hypervisor File System
To: Pekka Enberg <penberg@cs.helsinki.fi>
Cc: ioe-lkml@rameria.de, joern@wohnheim.fh-wedel.de,
       linux-kernel@vger.kernel.org, mschwid2@de.ibm.com, akpm@osdl.org
X-Mailer: Lotus Notes Build V70_M4_01112005 Beta 3NP January 11, 2005
Message-ID: <OFE6B79564.F8AA5D6A-ON4225715B.00433517-4225715B.0043FD0A@de.ibm.com>
From: Michael Holzheu <HOLZHEU@de.ibm.com>
Date: Tue, 25 Apr 2006 14:22:37 +0200
X-MIMETrack: Serialize by Router on D12ML061/12/M/IBM(Release 6.53HF654 | July 22, 2005) at
 25/04/2006 14:23:40
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pekka Enberg <penberg@cs.helsinki.fi> wrote on 04/25/2006 09:32:16 AM:
> On Mon, 2006-04-24 at 19:19 +0200, Michael Holzheu wrote:
> > > +#ifndef __HAVE_ARCH_STRRTRIM
> > > +/**
> > > + * strrtrim - Remove trailing characters specified in @reject
> > > + * @s: The string to be searched
> > > + * @reject: The string of letters to avoid
> > > + */
> > > +void strrtrim(char *s, const char *reject)
>
> On Tue, 2006-04-25 at 09:58 +0300, Pekka Enberg wrote:
> > I think this should return s to be consistent with other string API
> > functions.
>
> Hmm, thinking about this, I think a better API would be to not have that
> reject parameter at all. Would something like this be accetable for your
> use?

Yes, strtrip() will work for us! If Andrew takes it, I will use it in my
patch!

Thanks

Michael

