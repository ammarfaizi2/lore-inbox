Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268980AbUJTScA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268980AbUJTScA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 14:32:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269001AbUJTSb6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 14:31:58 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:62114 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S268980AbUJTS24 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 14:28:56 -0400
Subject: Re: [PATCH 1/3] Separate IRQ-stacks from 4K-stacks option
From: Lee Revell <rlrevell@joe-job.com>
To: Timothy Miller <miller@techsource.com>
Cc: Arjan van de Ven <arjanv@redhat.com>, Andrea Arcangeli <andrea@novell.com>,
       Hugh Dickins <hugh@veritas.com>, "Martin J. Bligh" <mbligh@aracnet.com>,
       Andrea Arcangeli <andrea@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Chris Wedgwood <cw@f00f.org>, LKML <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@infradead.org>
In-Reply-To: <4176ADA1.1090802@techsource.com>
References: <593560000.1094826651@[10.10.2.4]>
	 <Pine.LNX.4.44.0409101555510.16784-100000@localhost.localdomain>
	 <20040910151538.GA24434@devserv.devel.redhat.com>
	 <20040910152852.GC15643@x30.random>
	 <20040910153421.GD24434@devserv.devel.redhat.com>
	 <41768858.8070709@techsource.com>
	 <20041020153521.GB21556@devserv.devel.redhat.com>
	 <1098290345.1429.65.camel@krustophenia.net>
	 <4176A749.8050306@techsource.com>
	 <1098294932.1429.153.camel@krustophenia.net>
	 <4176ADA1.1090802@techsource.com>
Content-Type: text/plain
Message-Id: <1098296935.1429.174.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 20 Oct 2004 14:28:55 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-10-20 at 14:25, Timothy Miller wrote:
> I believe using the word 'draconian' was a poor choice on my part. 
> Maybe "strictly bounded with no exceptions" would be a better way of 
> expressing it.
> 

What I was asking is what rules you are referring to.  Do you mean
obvious ones like "no sleeping in ISRs", or guidelines like "ISRs must
execute quickly" where "quickly" is defined by some consensus?

Anyway my point is that if you mean the latter then the rules are not
quite draconian.  Fortunately this seems to be the only exception, and
the problem and the fix seem to be well understood.

I should add that unless LBA48 is in use the max request size is 128KB
which effectively hides the issue.

Lee

