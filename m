Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271938AbRIDK27>; Tue, 4 Sep 2001 06:28:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271936AbRIDK2t>; Tue, 4 Sep 2001 06:28:49 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:57268 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S271932AbRIDK2d>;
	Tue, 4 Sep 2001 06:28:33 -0400
Date: Tue, 4 Sep 2001 06:28:50 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Xavier Bestel <xavier.bestel@free.fr>
cc: Jean-Marc Saffroy <saffroy@ri.silicomp.fr>,
        Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
        Bryan Henderson <hbryan@us.ibm.com>, linux-fsdevel@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [RFD] readonly/read-write semantics
In-Reply-To: <999598828.11178.8.camel@nomade>
Message-ID: <Pine.GSO.4.21.0109040628070.26423-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 4 Sep 2001, Xavier Bestel wrote:

> > ??? Rollback is purely local thing, so NFS client doesn't matter at all.
> > And nfsd is just an application running on server, whether it's a kernel
> > thread or a normal process.
> 
> Sorry, I meant journal replaying ... AFAIK, this operation will write on
> the media even if mounted r/o.

Ditto - NFS client has no idea of that operation.

