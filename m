Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313504AbSD3NN6>; Tue, 30 Apr 2002 09:13:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313508AbSD3NN6>; Tue, 30 Apr 2002 09:13:58 -0400
Received: from johnsl.lnk.telstra.net ([139.130.12.152]:56842 "HELO
	ns.higherplane.net") by vger.kernel.org with SMTP
	id <S313504AbSD3NN5>; Tue, 30 Apr 2002 09:13:57 -0400
Date: Tue, 30 Apr 2002 23:15:23 +1000
From: john slee <indigoid@higherplane.net>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [prepatch] address_space-based writeback
Message-ID: <20020430131523.GA22705@higherplane.net>
In-Reply-To: <5.1.0.14.2.20020427191820.04003500@pop.cus.cam.ac.uk> <5.1.0.14.2.20020429115231.00b1d900@pop.cus.cam.ac.uk> <15565.13742.140693.146727@laputa.namesys.com> <200204301217.g3UCGtX02871@Port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ cc list trimmed ]

On Tue, Apr 30, 2002 at 03:19:17PM -0200, Denis Vlasenko wrote:
> Why do we have to stich to concept of inode *numbers*?
> Because there are inode numbers in traditional Unix filesystems?

probably because there is software out there relying on them being
numbers and being able to do 'if(inum_a == inum_b) { same_file(); }'
as appropriate.  i can't think of a use for such a construct other than
preserving hardlinks in archives (does tar do this?) but i'm sure there
are others

like much of unix it's been there forever and has become such a natural
concept in people's heads that to change it now seems unthinkable.

much like the missing e in creat().

j.

-- 
R N G G   "Well, there it goes again... And we just sit 
 I G G G   here without opposable thumbs." -- gary larson
