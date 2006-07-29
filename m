Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752073AbWG2TfG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752073AbWG2TfG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jul 2006 15:35:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752074AbWG2TfF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jul 2006 15:35:05 -0400
Received: from mx1.suse.de ([195.135.220.2]:13014 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1752073AbWG2TfC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jul 2006 15:35:02 -0400
From: Andi Kleen <ak@suse.de>
To: kmannth@us.ibm.com
Subject: Re: [Patch] 1/5 in support of hot-add memory x86_64 nodes_add cleanup
Date: Sat, 29 Jul 2006 21:30:43 +0200
User-Agent: KMail/1.9.3
Cc: lkml <linux-kernel@vger.kernel.org>,
       lhms-devel <lhms-devel@lists.sourceforge.net>,
       discuss <discuss@x86-64.org>, andrew <akpm@osdl.org>,
       dave hansen <haveblue@us.ibm.com>,
       kame <kamezawa.hiroyu@jp.fujitsu.com>, konrad <darnok@us.ibm.com>
References: <1154141535.5874.145.camel@keithlap> <200607291824.25584.ak@suse.de> <1154200962.7900.28.camel@keithlap>
In-Reply-To: <1154200962.7900.28.camel@keithlap>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607292130.43189.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> It was suggested to me in an earlier patch set to move RESERVE_HOTADD to
> Kconfig. 

It doesn't make any sense to me.

> I can make it a non-user option.  It seems that MEMORY_HOTPLUG 
> is a user options so I figured why not make RESERVE one as well.  Also I
> don't think people should use reserve with sparsmem. 

There should be a single high level Kconfig option for each feature.


-Andi
