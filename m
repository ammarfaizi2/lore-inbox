Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261861AbVC3LBm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261861AbVC3LBm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 06:01:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261862AbVC3LBm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 06:01:42 -0500
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:5030 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP id S261861AbVC3LBk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 06:01:40 -0500
Subject: Re: [patch 1/2] fork_connector: add a fork connector
From: Guillaume Thouvenin <guillaume.thouvenin@bull.net>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Paul Jackson <pj@engr.sgi.com>, Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
       Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
       lkml <linux-kernel@vger.kernel.org>, Jay Lan <jlan@engr.sgi.com>,
       Erich Focht <efocht@hpce.nec.com>, Ram <linuxram@us.ibm.com>,
       Gerrit Huizenga <gh@us.ibm.com>,
       elsa-devel <elsa-devel@lists.sourceforge.net>
In-Reply-To: <E1DGaOG-0002Md-00@gondolin.me.apana.org.au>
References: <E1DGaOG-0002Md-00@gondolin.me.apana.org.au>
Date: Wed, 30 Mar 2005 13:01:28 +0200
Message-Id: <1112180488.8426.146.camel@frecb000711.frec.bull.fr>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 30/03/2005 13:11:14,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 30/03/2005 13:11:17,
	Serialize complete at 30/03/2005 13:11:17
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-03-30 at 20:25 +1000, Herbert Xu wrote:
> Paul Jackson <pj@engr.sgi.com> wrote:
> > 
> > So I suppose if fork_connector were not used to collect <parent pid,
> > child pid> information for accounting, then someone would have to make
> > the case that there were enough other uses, of sufficient value, to add
> > fork_connector.  We have to be a bit careful, in the kernel, to avoid
> > adding mechanisms until we have the immediate use in hand.  If we don't
> > do this, then the kernel ends up looking like the Gargoyles on a
> > Renaissance church - burdened with overly ornate features serving no
> > earthly purpose.
> 
> I agree completely.  In fact the whole drivers/connector directory
> looks pretty suspect.  Are there any in-kernel users of it at all?

There is the Enhanced Linux System Accounting project 
http://elsa.sourceforge.net

Guillaume

