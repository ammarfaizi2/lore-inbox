Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265312AbUFBXE3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265312AbUFBXE3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 19:04:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265316AbUFBXE3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 19:04:29 -0400
Received: from hera.cwi.nl ([192.16.191.8]:24042 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S265312AbUFBXE0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 19:04:26 -0400
Date: Thu, 3 Jun 2004 01:03:09 +0200
From: Andries Brouwer <Andries.Brouwer@cwi.nl>
To: "Patrick J. LoPresti" <patl@users.sourceforge.net>
Cc: akpm@osdl.org, Matt Domsch <Matt_Domsch@dell.com>, Andries.Brouwer@cwi.nl,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Better names for EDD legacy_* fields
Message-ID: <20040602230309.GR23408@apps.cwi.nl>
References: <20040530200300.GA4681@apps.cwi.nl> <s5g8yf9ljb3.fsf@patl=users.sf.net> <20040531180821.GC5257@louise.pinerecords.com> <s5gaczonzej.fsf@patl=users.sf.net> <20040531170347.425c2584.seanlkml@sympatico.ca> <s5gfz9f2vok.fsf@patl=users.sf.net> <20040601235505.GA23408@apps.cwi.nl> <s5gpt8ijf1g.fsf@patl=users.sf.net> <20040602150051.GA3165@lists.us.dell.com> <s5ghdttlkvg.fsf@patl=users.sf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5ghdttlkvg.fsf@patl=users.sf.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 02, 2004 at 05:22:50PM -0400, Patrick J. LoPresti wrote:

> > > > Please, now that this is still unused, fix your names and/or
> > > > your code. Names could be legacy_max_head (etc.)
> 
> Trivial (search & replace) patch against 2.6.6 is attached.  This
> renames legacy_heads to legacy_max_head legacy_sectors to
> legacy_sectors_per_track.

Ach - I should have been more explicit instead of saying (etc.).
Also legacy_cylinders is really legacy_max_cylinder
(one less than the number of cylinders).

Andries
