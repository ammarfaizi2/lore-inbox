Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262638AbVBYG6o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262638AbVBYG6o (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Feb 2005 01:58:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262636AbVBYG6n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Feb 2005 01:58:43 -0500
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:945 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP id S262638AbVBYG5j
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Feb 2005 01:57:39 -0500
Subject: Re: [PATCH 2.6.11-rc4-mm1] end-of-proces handling for acct-csa
From: Guillaume Thouvenin <guillaume.thouvenin@bull.net>
To: Andrew Morton <akpm@osdl.org>
Cc: Jay Lan <jlan@sgi.com>, lkml <linux-kernel@vger.kernel.org>,
       Tim Schmielau <tim@physik3.uni-rostock.de>, kaigai@ak.jp.nec.com,
       jbarnes@sgi.com
In-Reply-To: <20050224204646.704680e9.akpm@osdl.org>
References: <421EA8FF.1050906@sgi.com>
	 <20050224204646.704680e9.akpm@osdl.org>
Date: Fri, 25 Feb 2005 07:57:40 +0100
Message-Id: <1109314660.1738.206.camel@frecb000711.frec.bull.fr>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 25/02/2005 08:06:36,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 25/02/2005 08:06:37,
	Serialize complete at 25/02/2005 08:06:37
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-02-24 at 20:46 -0800, Andrew Morton wrote:
> Jay Lan <jlan@sgi.com> wrote:
> >
> > Since my idea of providing an accounting framework was considered
> >  'overkill', here i submit a tiny patch just to allow CSA to
> >  handle end-of-process (eop) situation by saving off accounting
> >  data before a task_struct is disposed.
> > 
> >  This patch is to modify the acct_process() in acct.c, which is
> >  invoked from do_exit() to handle eop for BSD accounting. Now
> >  the acct_process() wrapper will also take care of CSA, if it has
> >  been loaded. If the CSA module has been loaded, a CSA routine
> >  will be invoked to construct a CSA job record and to write the
> >  record to the CSA accounting file.
> 
> I really don't want to have to (and shouldn't need to) become an accounting
> person, but as there seems to be a communication problem somewhere..
> 
> Please, you guys are the subject matter experts.  Put your heads together
> and come up with something.

I completely agree with that and we will continue this conversation in
private with Jay and all people involved to come up with an appropriate
solution.

Guillaume

