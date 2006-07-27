Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751911AbWG0SO5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751911AbWG0SO5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 14:14:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751654AbWG0SO5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 14:14:57 -0400
Received: from tetsuo.zabbo.net ([207.173.201.20]:45983 "EHLO tetsuo.zabbo.net")
	by vger.kernel.org with ESMTP id S1751888AbWG0SO4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 14:14:56 -0400
Message-ID: <44C9029A.4090705@oracle.com>
Date: Thu, 27 Jul 2006 11:14:50 -0700
From: Zach Brown <zach.brown@oracle.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Badari Pulavarty <pbadari@us.ibm.com>
CC: =?ISO-8859-15?Q?S=E9bastien_Dugu=E9?= <sebastien.dugue@bull.net>,
       Ulrich Drepper <drepper@redhat.com>,
       Christoph Hellwig <hch@infradead.org>,
       Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
       lkml <linux-kernel@vger.kernel.org>, David Miller <davem@davemloft.net>,
       netdev <netdev@vger.kernel.org>,
       Suparna Bhattacharya <suparna@in.ibm.com>
Subject: Re: [3/4] kevent: AIO, aio_sendfile() implementation.
References: <1153905495613@2ka.mipt.ru> <11539054952574@2ka.mipt.ru>	 <20060726100431.GA7518@infradead.org> <20060726101919.GB2715@2ka.mipt.ru>	 <20060726103001.GA10139@infradead.org> <44C77C23.7000803@redhat.com>	 <44C796C3.9030404@us.ibm.com> <1153982954.3887.9.camel@frecb000686> <44C8DB80.6030007@us.ibm.com>
In-Reply-To: <44C8DB80.6030007@us.ibm.com>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Suparna mentioned at Ulrich wants us to concentrate on kernel-side 
> support, so that he can look at glibc side of things (along with
> other work he is already doing). So, if we can get an agreement on
> what kind of kernel support is needed - we can focus our efforts on
> kernel side first and leave glibc enablement to capable hands of Uli
> :)

Yeah, and the existing patches still need some cleanup.  Badari, did you
still want me to look into that?

We need someone to claim ultimate responsibility for getting these
patches suitable for merging :).  I'm happy to do that if Suparna isn't
already on it.

- z
