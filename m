Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030196AbWG1Hb1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030196AbWG1Hb1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 03:31:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030179AbWG1Hb0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 03:31:26 -0400
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:29628 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP id S932586AbWG1HbZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 03:31:25 -0400
Subject: Re: [3/4] kevent: AIO, aio_sendfile() implementation.
From: =?ISO-8859-1?Q?S=E9bastien_Dugu=E9?= <sebastien.dugue@bull.net>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: Ulrich Drepper <drepper@redhat.com>, Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
       lkml <linux-kernel@vger.kernel.org>, David Miller <davem@davemloft.net>,
       netdev <netdev@vger.kernel.org>,
       Suparna Bhattacharya <suparna@in.ibm.com>
In-Reply-To: <1154034164.29920.22.camel@dyn9047017100.beaverton.ibm.com>
References: <1153905495613@2ka.mipt.ru> <11539054952574@2ka.mipt.ru>
	 <20060726100431.GA7518@infradead.org> <20060726101919.GB2715@2ka.mipt.ru>
	 <20060726103001.GA10139@infradead.org> <44C77C23.7000803@redhat.com>
	 <44C796C3.9030404@us.ibm.com> <1153982954.3887.9.camel@frecb000686>
	 <44C8DB80.6030007@us.ibm.com>  <44C9029A.4090705@oracle.com>
	 <1154024943.29920.3.camel@dyn9047017100.beaverton.ibm.com>
	 <44C90987.1040200@redhat.com>
	 <1154034164.29920.22.camel@dyn9047017100.beaverton.ibm.com>
Date: Fri, 28 Jul 2006 09:31:15 +0200
Message-Id: <1154071875.13577.8.camel@frecb000686>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 28/07/2006 09:36:04,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 28/07/2006 09:36:05,
	Serialize complete at 28/07/2006 09:36:05
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-07-27 at 14:02 -0700, Badari Pulavarty wrote:
> On Thu, 2006-07-27 at 11:44 -0700, Ulrich Drepper wrote:
> > Badari Pulavarty wrote:
> > > Before we spend too much time cleaning up and merging into mainline -
> > > I would like an agreement that what we add is good enough for glibc
> > > POSIX AIO.
> > 
> > I haven't seen a description of the interface so far.  Would be good if
> > it existed.  But I briefly mentioned one quirk in the interface about
> > which Suparna wasn't sure whether it's implemented/implementable in the
> > current interface.
> 
> Sebastien, could you provide a description of interfaces you are
> adding ? Since you did all the work, it would be appropriate for
> you to do it :)
> 

  I will clean up what description I have and send it soon.

  S�bastien.


-- 
-----------------------------------------------------

  S�bastien Dugu�                BULL/FREC:B1-247
  phone: (+33) 476 29 77 70      Bullcom: 229-7770

  mailto:sebastien.dugue@bull.net

  Linux POSIX AIO: http://www.bullopensource.org/posix
                   http://sourceforge.net/projects/paiol

-----------------------------------------------------

