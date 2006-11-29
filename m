Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966970AbWK2Kql@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966970AbWK2Kql (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 05:46:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967012AbWK2Kql
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 05:46:41 -0500
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:60138 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP id S966970AbWK2Kqk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 05:46:40 -0500
Date: Wed, 29 Nov 2006 11:46:44 +0100
From: =?ISO-8859-1?Q?S=E9bastien_Dugu=E9?= <sebastien.dugue@bull.net>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-aio <linux-aio@kvack.org>, Andrew Morton <akpm@osdl.org>,
       Suparna Bhattacharya <suparna@in.ibm.com>,
       Christoph Hellwig <hch@infradead.org>,
       Zach Brown <zach.brown@oracle.com>,
       Badari Pulavarty <pbadari@us.ibm.com>,
       Ulrich Drepper <drepper@redhat.com>,
       Jean Pierre Dion <jean-pierre.dion@bull.net>
Subject: Re: [PATCH -mm 3/5][AIO] - export good_sigevent()
Message-ID: <20061129114644.2b027be2@frecb000686>
In-Reply-To: <20061129103825.GA1773@infradead.org>
References: <20061129112441.745351c9@frecb000686>
	<20061129113234.38c12911@frecb000686>
	<20061129103825.GA1773@infradead.org>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 29/11/2006 11:53:49,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 29/11/2006 11:53:51,
	Serialize complete at 29/11/2006 11:53:51
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Nov 2006 10:38:25 +0000
Christoph Hellwig <hch@infradead.org> wrote:

> On Wed, Nov 29, 2006 at 11:32:34AM +0100, S?bastien Dugu? wrote:
> > 
> >                       Export good_sigevent()
> > 
> > 
> >   Move good_sigevent() from posix-timers.c to signal.c where it belongs,
> > and export it so that it can be used by other subsystems.
> 
> A little nitpick about the subject: we usually use the term 'export' when
> adding an EXPORT_SYMBOL.  What would better describe your patch is
> 
> 'make good_sigevent non-static'
> 

  No problem.

  Thanks,

  Sébastien.
