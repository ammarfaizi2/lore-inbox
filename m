Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129040AbQKNXpp>; Tue, 14 Nov 2000 18:45:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129045AbQKNXpf>; Tue, 14 Nov 2000 18:45:35 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:13070 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S129040AbQKNXpe>;
	Tue, 14 Nov 2000 18:45:34 -0500
Message-ID: <3A11C75F.6F8C0B64@mandrakesoft.com>
Date: Tue, 14 Nov 2000 18:14:39 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Dan Aloni <karrde@callisto.yi.org>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Re: test11-pre5
In-Reply-To: <Pine.LNX.4.21.0011150104250.26856-100000@callisto.yi.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Aloni wrote:
> 
> On Tue, 14 Nov 2000, Jeff Garzik wrote:
> 
> > Dan Aloni wrote:
> > >
> > > reason: Correct me if I'm wrong, but 3c501.c:init_module() calls
> > > net_init.c:register_netdev(&dev_3c501), which calls strchr(),
> > > {and might also,which might} dereference dev_3c501.name.
> >
> > There is no dereferencing involved, and therefore no problem.
> 
> Well, at least I was alertive. Almost a bug fix ;-)
> Is there a special reason why dev->name is not a pointer?

IIRC, it made things easier when Alan (or others?) updated the ether=xxx
command line support..

-- 
Jeff Garzik             |
Building 1024           | The chief enemy of creativity is "good" sense
MandrakeSoft            |          -- Picasso
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
