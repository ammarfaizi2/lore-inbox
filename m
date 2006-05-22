Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751054AbWEVRXR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751054AbWEVRXR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 13:23:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751061AbWEVRXR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 13:23:17 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:51854 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751050AbWEVRXQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 13:23:16 -0400
Subject: Re: [PATCH 2/4] Remove readv/writev methods and use
	aio_read/aio_write instead
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: christoph <hch@lst.de>, Benjamin LaHaise <bcrl@kvack.org>,
       cel@citi.umich.edu, Zach Brown <zach.brown@oracle.com>,
       lkml <linux-kernel@vger.kernel.org>, raven@themaw.net
In-Reply-To: <20060522100640.0710f7da.akpm@osdl.org>
References: <1146582438.8373.7.camel@dyn9047017100.beaverton.ibm.com>
	 <1147197826.27056.4.camel@dyn9047017100.beaverton.ibm.com>
	 <1147361890.12117.11.camel@dyn9047017100.beaverton.ibm.com>
	 <1147727945.20568.53.camel@dyn9047017100.beaverton.ibm.com>
	 <1147728133.6181.2.camel@dyn9047017100.beaverton.ibm.com>
	 <20060521180037.3c8f2847.akpm@osdl.org>
	 <1148310016.7214.26.camel@dyn9047017100.beaverton.ibm.com>
	 <20060522100640.0710f7da.akpm@osdl.org>
Content-Type: text/plain
Date: Mon, 22 May 2006 10:24:31 -0700
Message-Id: <1148318671.7214.42.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-05-22 at 10:06 -0700, Andrew Morton wrote:
> Badari Pulavarty <pbadari@us.ibm.com> wrote:
> >
> > On Sun, 2006-05-21 at 18:00 -0700, Andrew Morton wrote:
> > > Badari Pulavarty <pbadari@us.ibm.com> wrote:
> > > >
> > > > This patch removes readv() and writev() methods and replaces
> > > >  them with aio_read()/aio_write() methods.
> > > 
> > > And it breaks autofs4
> > > 
> > > autofs: pipe file descriptor does not contain proper ops
> > > 
> > 
> > Any easy test case to reproduce the problem ?
> > 
> 
> Grab an FC5 setup, copy RH's .config into your tree.

Will do. 

Like I mentioned, I am travelling this week. I would really
appreciate if someone could test my updated patch (I sent out
in my earlier mail).

Thanks,
Badari

