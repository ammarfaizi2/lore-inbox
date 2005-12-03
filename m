Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750912AbVLCLWR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750912AbVLCLWR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Dec 2005 06:22:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750965AbVLCLWR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Dec 2005 06:22:17 -0500
Received: from mail.gmx.de ([213.165.64.20]:10141 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750921AbVLCLWQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Dec 2005 06:22:16 -0500
X-Authenticated: #428038
Date: Sat, 3 Dec 2005 12:22:08 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: Heinz Mauelshagen <mauelshagen@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH] aic79xx should be able to ignore HostRAID enabled adapters
Message-ID: <20051203112208.GC31216@merlin.emma.line.org>
Mail-Followup-To: Heinz Mauelshagen <mauelshagen@redhat.com>,
	linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
References: <547AF3BD0F3F0B4CBDC379BAC7E4189F01E3E318@otce2k03.adaptec.com> <20051201144745.GI2782@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051201144745.GI2782@redhat.com>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 01 Dec 2005, Heinz Mauelshagen wrote:

> On Thu, Dec 01, 2005 at 08:44:15AM -0500, Salyzyn, Mark wrote:
> > Christoph Hellwig sez:
> > > NACK.  We're not going to support attaching broken propritary drivers.
> > 
> > Understood and expected.
> > 
> > The word 'broken' is hardly chosen for scientific reasons, bespeaks an
> > agenda ;-> Just because you can not see the code, does not mean it is
> > broken.
> > 
> > I have on numerous attempts tried to contact Heinz Mauelshagen to
> > fortify dmraid in support of the HostRAID adapters. He has yet to
> > respond to my emails to start a dialogue with Adaptec.
> 
> None of those here.
> Please forward.

I also sent an email a few weeks ago and haven't heard back yet.

In my message I asked whether it was feasible for you to look at
FreeBSD's "ataraid(4)" driver to learn the Intel ICHx-R SoftRAID format.
I know FreeBSD understands this format, and dmraid did not when I sent
the email.

The hardware I was looking at is ICH7-R. It only works in compatibility
mode, which only saw one drive for some reason.

Bottom line: 3Ware Escalade are cheap enough not to bother with this
SoftRAID stuff...

-- 
Matthias Andree
