Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271945AbRIDLED>; Tue, 4 Sep 2001 07:04:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271943AbRIDLDx>; Tue, 4 Sep 2001 07:03:53 -0400
Received: from d179.dhcp212-198-121.noos.fr ([212.198.121.179]:52742 "EHLO
	microsoft.com") by vger.kernel.org with ESMTP id <S271941AbRIDLDf>;
	Tue, 4 Sep 2001 07:03:35 -0400
Subject: Re: [RFD] readonly/read-write semantics
From: Xavier Bestel <xavier.bestel@free.fr>
To: Alexander Viro <viro@math.psu.edu>
Cc: Jean-Marc Saffroy <saffroy@ri.silicomp.fr>,
        Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
        Bryan Henderson <hbryan@us.ibm.com>, linux-fsdevel@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
In-Reply-To: <Pine.GSO.4.21.0109040628070.26423-100000@weyl.math.psu.edu>
In-Reply-To: <Pine.GSO.4.21.0109040628070.26423-100000@weyl.math.psu.edu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.12.99+cvs.2001.08.22.00.33 (Preview Release)
Date: 04 Sep 2001 12:59:10 +0200
Message-Id: <999601150.11170.11.camel@nomade>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On mar, 2001-09-04 at 12:28, Alexander Viro wrote:

> > Sorry, I meant journal replaying ... AFAIK, this operation will
write on
> > the media even if mounted r/o.
> 
> Ditto - NFS client has no idea of that operation.

Another client mounting the same fs at the same time will have a rather
weird idea of that operation.


