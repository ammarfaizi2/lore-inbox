Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751245AbVI2J3t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751245AbVI2J3t (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 05:29:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751297AbVI2J3t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 05:29:49 -0400
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:53459 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP
	id S1751245AbVI2J3t convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 05:29:49 -0400
Subject: Re: AIO Support and related package information??
From: =?ISO-8859-1?Q?S=E9bastien_Dugu=E9?= <sebastien.dugue@bull.net>
To: vikas gupta <vikas_gupta51013@yahoo.co.in>
Cc: linux-aio@kvack.org, linux-kernel@vger.kernel.org, bcrl@kvack.org
In-Reply-To: <20050928140458.53545.qmail@web8409.mail.in.yahoo.com>
References: <20050928140458.53545.qmail@web8409.mail.in.yahoo.com>
Date: Thu, 29 Sep 2005 11:31:37 +0200
Message-Id: <1127986297.2103.53.camel@frecb000686>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 29/09/2005 11:43:05,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 29/09/2005 11:43:07,
	Serialize complete at 29/09/2005 11:43:07
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-09-28 at 15:04 +0100, vikas gupta wrote:
> Hi Sebastein,
> 
> Thanks for Replying ....
> 
> > 
> >   This is perfectly normal as a vanilla kernel only
> > have
> > support for aio_read and aio_write without event
> > notification
> > so only aio_read_one and aio_write_one will pass
> 
> 1)well Whether these test cases will work after
> applying the patches to kernel

  The patches will make all the aio_read, aio_write, listio
and aio_suspend tests work. The aio_cancel and aio_fsync
still need support from the underlying fs.

> 
> 2)What all the patches we need to apply in order to
> provide full AIO  support on kernel 2.6.11 

  The patches are for the 2.6.10 or 2.6.12 kernel only,
sorry. 

  Sébastien.

-- 
------------------------------------------------------

  Sébastien Dugué                BULL/FREC:B1-247
  phone: (+33) 476 29 77 70      Bullcom: 229-7770

  mailto:sebastien.dugue@bull.net

  Linux POSIX AIO: http://www.bullopensource.org/posix
  
------------------------------------------------------

