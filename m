Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932070AbVJLX1J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932070AbVJLX1J (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 19:27:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932100AbVJLX1J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 19:27:09 -0400
Received: from mail.isurf.ca ([66.154.97.68]:35466 "EHLO columbo.isurf.ca")
	by vger.kernel.org with ESMTP id S932070AbVJLX1I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 19:27:08 -0400
From: "Gabriel A. Devenyi" <ace@staticwave.ca>
To: Chris Wright <chrisw@osdl.org>
Subject: Re: [OOPS] nfsv4 in linux 2.6.13 (-ck7)
Date: Wed, 12 Oct 2005 19:27:22 -0400
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org
References: <200510121903.04485.ace@staticwave.ca> <20051012232418.GQ7991@shell0.pdx.osdl.net>
In-Reply-To: <20051012232418.GQ7991@shell0.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510121927.22296.ace@staticwave.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On October 12, 2005 19:24, Chris Wright wrote:
> * Gabriel A. Devenyi (ace@staticwave.ca) wrote:
> > This oops seems to occur during heavy i/o load over nfsv4.
> > 
> >  [kernel] Unable to handle kernel paging request at 0000000000100108 RIP:
> >  [kernel] <ffffffff80185e98>{generic_drop_inode+56}
> 
> There have been a couple recent reports of this, and a fix is in the works.
> 
> See the recent thread here:
> 
> http://lkml.org/lkml/2005/9/25/44
> 
> >  [kernel] Modules linked in: nvidia
>                                ^^^^^^
> >  [kernel] Pid: 179, comm: kswapd0 Tainted: P      2.6.13-ck7
> 
> Tainted kernel, when sending bug reports please be sure bug happens
> w/out tainted kernel.

Of course, my apologies, however, this is a fs error, is it even conceivable that something such as the nvidia kernel driver could affect this?


> thanks,
> -chris
> 
> 

-- 
Gabriel A. Devenyi
ace@staticwave.ca
