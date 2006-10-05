Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932173AbWJEQq2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932173AbWJEQq2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 12:46:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932175AbWJEQq1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 12:46:27 -0400
Received: from gundega.hpl.hp.com ([192.6.19.190]:61399 "EHLO
	gundega.hpl.hp.com") by vger.kernel.org with ESMTP id S932173AbWJEQq1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 12:46:27 -0400
Date: Thu, 5 Oct 2006 09:35:13 -0700
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Theodore Tso <tytso@mit.edu>, "John W. Linville" <linville@tuxdriver.com>,
       Jeff Garzik <jeff@garzik.org>, jt@hpl.hp.com,
       Linus Torvalds <torvalds@osdl.org>, Lee Revell <rlrevell@joe-job.com>,
       Alessandro Suardi <alessandro.suardi@gmail.com>,
       Norbert Preining <preining@logic.at>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: wpa supplicant/ipw3945, ESSID last char missing
Message-ID: <20061005163513.GC6510@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <20061003123835.GA23912@tuxdriver.com> <1159890876.20801.65.camel@mindpipe> <Pine.LNX.4.64.0610030916000.3952@g5.osdl.org> <20061003180543.GD23912@tuxdriver.com> <4522A9BE.9000805@garzik.org> <20061003183849.GA17635@bougret.hpl.hp.com> <4522B311.7070905@garzik.org> <20061003214038.GE23912@tuxdriver.com> <20061003231648.GB26351@thunk.org> <1159948179.2817.26.camel@ux156>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1159948179.2817.26.camel@ux156>
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
User-Agent: Mutt/1.5.9i
From: Jean Tourrilhes <jt@hpl.hp.com>
X-HPL-MailScanner: Found to be clean
X-HPL-MailScanner-From: jt@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 04, 2006 at 09:49:39AM +0200, Johannes Berg wrote:
> On Tue, 2006-10-03 at 19:16 -0400, Theodore Tso wrote:
> 
> > OK, I'm going to ask a stupid question.  Why is the kernel<->wireless
> > driver interface have to be tied to the userspace<->wireless
> > interface?  
> 
> Haha. Because Jean thinks it isn't and thus everything is fine. But in
> reality it is.
> 
> > Is there some reason why this would be too hard to do with the current
> > interface?  
> 
> Yes: drivers are expected to mostly handle the ioctls directly without a
> layer between them and userspace.

	Once again, your facts are totally wrong about Wireless
Extensions.
	Have you ever looked at the code in the kernel ? I guarantee
you that adding whatever specific WE translation is quite easy. In
this precise case, this would only increase confusion, so this should
be considered bad API practice.
	Regards,

	Jean

