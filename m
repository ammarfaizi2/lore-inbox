Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271957AbRIDL3e>; Tue, 4 Sep 2001 07:29:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271956AbRIDL3Y>; Tue, 4 Sep 2001 07:29:24 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:29327 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S271951AbRIDL3P>;
	Tue, 4 Sep 2001 07:29:15 -0400
Date: Tue, 4 Sep 2001 07:29:33 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Xavier Bestel <xavier.bestel@free.fr>
cc: Jean-Marc Saffroy <saffroy@ri.silicomp.fr>,
        Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
        Bryan Henderson <hbryan@us.ibm.com>, linux-fsdevel@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [RFD] readonly/read-write semantics
In-Reply-To: <999601150.11170.11.camel@nomade>
Message-ID: <Pine.GSO.4.21.0109040728180.28149-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 4 Sep 2001, Xavier Bestel wrote:

> On mar, 2001-09-04 at 12:28, Alexander Viro wrote:
> 
> > > Sorry, I meant journal replaying ... AFAIK, this operation will
> write on
> > > the media even if mounted r/o.
> > 
> > Ditto - NFS client has no idea of that operation.
> 
> Another client mounting the same fs at the same time will have a rather
> weird idea of that operation.

"weird" == "no".

Client sees what nfsd does. And nfsd is an application, ferchrissake.
It's no different from "another process on server looks at the fs
at the same (what, BTW?) time".

