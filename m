Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266126AbTGITwJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 15:52:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266108AbTGITwJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 15:52:09 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:13188 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S266132AbTGITvs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 15:51:48 -0400
Date: Wed, 9 Jul 2003 16:13:07 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
Cc: Andreas Dilger <adilger@clusterfs.com>, Andrea Arcangeli <andrea@suse.de>,
       Christoph Hellwig <hch@infradead.org>, marcelo@connectiva.com.br,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: ->direct_IO API change in current 2.4 BK
In-Reply-To: <200307092022.35295.m.c.p@wolk-project.de>
Message-ID: <Pine.LNX.4.55L.0307091611140.29759@freak.distro.conectiva>
References: <20030709133109.A23587@infradead.org> <200307091954.12895.m.c.p@wolk-project.de>
 <Pine.LNX.4.55L.0307091506180.27004@freak.distro.conectiva>
 <200307092022.35295.m.c.p@wolk-project.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 9 Jul 2003, Marc-Christian Petersen wrote:

> On Wednesday 09 July 2003 20:08, Marcelo Tosatti wrote:
>
> Hi Marcelo,
>
> > Ok, right. Well, I dont know why it doesnt happen there. Maybe not enough
> > testing?
> aehm, I'll bet -aa is tested _alot_ and also -wolk has tons of testers, but
> well, this is a different talk ;)
>
> > Anyway, I'm going to revert the NFS DIRECT IO patch because, as Christoph
> > mentioned, breaks the API.
> > I except another solution from Trond (maybe ->direct_IO2).

> I wonder why you merge such stuff then in the first place, if you agree with
> hch's opinion, that an API should not change in stable kernel series in the
> 2nd place? ... Did you temporarly forget it? ;)

No, I did not.

I applied it because, in my ignorance, I did not noticed it would break
the stable API.

I applied it because I wanted comments useful from people (Like hch and
others did).

Thank you very much for your flaming.
