Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030303AbWGaSYL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030303AbWGaSYL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 14:24:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030307AbWGaSYL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 14:24:11 -0400
Received: from ns2.suse.de ([195.135.220.15]:4749 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030303AbWGaSYK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 14:24:10 -0400
From: Andi Kleen <ak@suse.de>
To: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH] Fix trivial unwind info bug
Date: Mon, 31 Jul 2006 13:23:18 +0200
User-Agent: KMail/1.9.1
Cc: Markus Armbruster <armbru@redhat.com>, linux-kernel@vger.kernel.org
References: <E1G7Z8C-0007IO-00@gondolin.me.apana.org.au>
In-Reply-To: <E1G7Z8C-0007IO-00@gondolin.me.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607311323.18466.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 31 July 2006 16:52, Herbert Xu wrote:
> Markus Armbruster <armbru@redhat.com> wrote:
> > CFA needs to be adjusted upwards for push, and downwards for pop.
> > arch/i386/kernel/entry.S gets it wrong in one place.
> >
> > Signed-off-by: Markus Armbruster <armbru@redhat.com>
>
> Thanks for the patch Markus.  Andi Kleen is now maintaining i386
> so please cc him in future for i386 patches.

Sorry, but that's not true. I do occassional i386 patches, but
overall it is still maintainerless or done by Andrew.

-Andi

