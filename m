Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030425AbWARUhM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030425AbWARUhM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 15:37:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030424AbWARUhM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 15:37:12 -0500
Received: from mail.dvmed.net ([216.237.124.58]:18876 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030422AbWARUhJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 15:37:09 -0500
Message-ID: <43CEA6EB.6080209@pobox.com>
Date: Wed, 18 Jan 2006 15:36:59 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "John W. Linville" <linville@tuxdriver.com>
CC: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, jbenc@suse.cz,
       softmac-dev@sipsolutions.net, bcm43xx-dev@lists.berlios.de
Subject: Re: wireless: the contenders
References: <20060118200616.GC6583@tuxdriver.com>
In-Reply-To: <20060118200616.GC6583@tuxdriver.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.1 (/)
X-Spam-Report: Spam detection software, running on the system "srv2.dvmed.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  John W. Linville wrote: > First, the news everyone will
	like. Thanks to the kernel.org team > I now have a place to publish a
	wireless tree: > >
	git://git.kernel.org/pub/scm/linux/kernel/git/linville/wireless-2.6.git
	> > The tree there has a number of branches, so many that you need > a
	scorecard... > > Branches > -------- > > The "master" branch of that
	tree is (mostly) up-to-date w/ Linus, plus > changes I recently sent to
	Jeff. Those changes are also available on > the "upstream-jgarzik"
	branch, but it is frozen to when I requested > Jeff's pull. [...] 
	Content analysis details:   (0.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[69.134.188.146 listed in dnsbl.sorbs.net]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John W. Linville wrote:
> First, the news everyone will like.  Thanks to the kernel.org team
> I now have a place to publish a wireless tree:
> 
>    git://git.kernel.org/pub/scm/linux/kernel/git/linville/wireless-2.6.git
> 
> The tree there has a number of branches, so many that you need
> a scorecard...
> 
> Branches
> --------
> 
> The "master" branch of that tree is (mostly) up-to-date w/ Linus, plus
> changes I recently sent to Jeff.  Those changes are also available on
> the "upstream-jgarzik" branch, but it is frozen to when I requested
> Jeff's pull.

Minor git administrative note...  In my trees, the 'master' branch is 
always vanilla Linus, and I never ever apply my own changes to it.  This 
enables commands such as

	git diff master..upstream > patch
	git log master..upstream > log.txt
	git log master..upstream | git shortlog > shortlog.txt

to work as expected.

Typically I do not update 'master' unless I am also updating 'upstream' 
with vanilla Linus changes, in order to avoid screwing up the tree heads 
and the diff.  When I do update 'master' from 'upstream', it is a 
trivial matter to then pull those changes into 'upstream':

	git checkout -f upstream
	git pull . master

Regards,

	Jeff


