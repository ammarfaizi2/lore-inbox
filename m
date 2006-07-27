Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750938AbWG0S0m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750938AbWG0S0m (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 14:26:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751935AbWG0S0m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 14:26:42 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:56496 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750938AbWG0S0l
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 14:26:41 -0400
Subject: Re: [3/4] kevent: AIO, aio_sendfile() implementation.
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Zach Brown <zach.brown@oracle.com>
Cc: =?ISO-8859-1?Q?S=E9bastien_Dugu=E9?= <sebastien.dugue@bull.net>,
       Ulrich Drepper <drepper@redhat.com>,
       Christoph Hellwig <hch@infradead.org>,
       Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
       lkml <linux-kernel@vger.kernel.org>, David Miller <davem@davemloft.net>,
       netdev <netdev@vger.kernel.org>,
       Suparna Bhattacharya <suparna@in.ibm.com>
In-Reply-To: <44C9029A.4090705@oracle.com>
References: <1153905495613@2ka.mipt.ru> <11539054952574@2ka.mipt.ru>
	 <20060726100431.GA7518@infradead.org> <20060726101919.GB2715@2ka.mipt.ru>
	 <20060726103001.GA10139@infradead.org> <44C77C23.7000803@redhat.com>
	 <44C796C3.9030404@us.ibm.com> <1153982954.3887.9.camel@frecb000686>
	 <44C8DB80.6030007@us.ibm.com>  <44C9029A.4090705@oracle.com>
Content-Type: text/plain
Date: Thu, 27 Jul 2006 11:29:03 -0700
Message-Id: <1154024943.29920.3.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-07-27 at 11:14 -0700, Zach Brown wrote:
> > Suparna mentioned at Ulrich wants us to concentrate on kernel-side 
> > support, so that he can look at glibc side of things (along with
> > other work he is already doing). So, if we can get an agreement on
> > what kind of kernel support is needed - we can focus our efforts on
> > kernel side first and leave glibc enablement to capable hands of Uli
> > :)
> 
> Yeah, and the existing patches still need some cleanup.  Badari, did you
> still want me to look into that?
> 
> We need someone to claim ultimate responsibility for getting these
> patches suitable for merging :).  I'm happy to do that if Suparna isn't
> already on it.

Zach,

Thanks for volunteering !! Sebastien & I should be able to help you.

Before we spend too much time cleaning up and merging into mainline -
I would like an agreement that what we add is good enough for glibc
POSIX AIO. I hate to waste everyone's time and add complexity to the
kernel - if glibc side is not going to happen :(

Thanks,
Badari

