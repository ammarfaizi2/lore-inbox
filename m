Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261435AbVC3Fwh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261435AbVC3Fwh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 00:52:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261472AbVC3Fwh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 00:52:37 -0500
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:38272 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP id S261435AbVC3Fwa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 00:52:30 -0500
Subject: Re: [patch 1/2] fork_connector: add a fork connector
From: Guillaume Thouvenin <guillaume.thouvenin@bull.net>
To: Paul Jackson <pj@engr.sgi.com>
Cc: Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
       lkml <linux-kernel@vger.kernel.org>,
       Evgeniy Polyakov <johnpol@2ka.mipt.ru>, Jay Lan <jlan@engr.sgi.com>,
       Erich Focht <efocht@hpce.nec.com>, Ram <linuxram@us.ibm.com>,
       Gerrit Huizenga <gh@us.ibm.com>,
       elsa-devel <elsa-devel@lists.sourceforge.net>
In-Reply-To: <20050329073558.797001c1.pj@engr.sgi.com>
References: <1111745010.684.49.camel@frecb000711.frec.bull.fr>
	 <20050328134242.4c6f7583.pj@engr.sgi.com>
	 <1112100675.8426.72.camel@frecb000711.frec.bull.fr>
	 <20050329073558.797001c1.pj@engr.sgi.com>
Date: Wed, 30 Mar 2005 07:52:19 +0200
Message-Id: <1112161939.20919.96.camel@frecb000711.frec.bull.fr>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 30/03/2005 08:02:05,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 30/03/2005 08:02:08,
	Serialize complete at 30/03/2005 08:02:08
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-03-29 at 07:35 -0800, Paul Jackson wrote:
> Guillaume wrote:
> > I ran some test using the CBUS instead of the cn_netlink_send() routine
> > and the overhead is nearly 0%:
> 
> Overhead of what?  Does this include merging the data and getting it to
> disk?

I test the overhead of sending the fork information to a user space
application. The merge of the data is done later and it has nothing to
do with the fork connector...

> Am I even asking the right question here - is it true that this data,
> when collected for accounting purposes, needs to go to disk, and that
> summarizing and analyzing the data is done 'off-line', perhaps hours
> later?  That's the way it was 25 years ago ... but perhaps the basic
> data flow appropriate for accounting has changed since then.

  Accounting is another problem and, as you said previously, summarizing
and analyzing the data is done later. 

  I'm sorry but I really don't understand why you're speaking about
accounting when I present results about fork connector. I agree that
ELSA is using the fork connector but the fork connector has nothing to
do with accounting.

Regards,
Guillaume


