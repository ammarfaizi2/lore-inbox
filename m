Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130668AbRAGMGo>; Sun, 7 Jan 2001 07:06:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130880AbRAGMGd>; Sun, 7 Jan 2001 07:06:33 -0500
Received: from twilight.cs.hut.fi ([130.233.40.5]:1059 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S130668AbRAGMG3>; Sun, 7 Jan 2001 07:06:29 -0500
Date: Sun, 7 Jan 2001 14:06:07 +0200
From: Ville Herva <vherva@mail.niksula.cs.hut.fi>
To: Andre Tomt <andre@tomt.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jim Olsen <jim@browsermedia.com>
Subject: Re: Which kernel fixes the VM issues?
Message-ID: <20010107140607.J1265@niksula.cs.hut.fi>
In-Reply-To: <01010706312902.10913@jim.cyberjunkees.com> <OPECLOJPBIHLFIBNOMGBAENACHAA.andre@tomt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <OPECLOJPBIHLFIBNOMGBAENACHAA.andre@tomt.net>; from andre@tomt.net on Sun, Jan 07, 2001 at 12:50:07PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 07, 2001 at 12:50:07PM +0100, you [Andre Tomt] claimed:
> > of the fuzz
> > I have relating to the VM: do_try_to_free_pages issue.
> 
> <snip>
> 
> > About once a week I get the 'VM: do_try_to_free_pages ...' error and
> > eventually get a complete system lockup. And just this morning it
> > locked up
> > again, although this time with a 'VFS: LRU block list corrupted'
> > message in
> > the logs, which i'm assuming is related to the VM issue as well.
> 
> This issue is fixed in 2.2.18 AFAIK (never seen it since).
> 
> <snip>

Nope.

It's fixed 2.2.19pre2 (which includes the Andrea Arcangeli's vm-global-7
patch that (among other things) fixes this.)

You can also apply the vm-global-patch to 2.2.18 if you like.


-- v --

v@iki.fi
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
