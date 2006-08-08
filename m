Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932260AbWHHGsJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932260AbWHHGsJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 02:48:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932269AbWHHGsI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 02:48:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:61072 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932260AbWHHGsH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 02:48:07 -0400
From: Andi Kleen <ak@suse.de>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH] x86_64:  Auto size the per cpu area.
Date: Tue, 8 Aug 2006 08:48:03 +0200
User-Agent: KMail/1.9.3
Cc: Andrew Morton <akpm@osdl.org>, "Randy.Dunlap" <rdunlap@xenotime.net>,
       "Protasevich, Natalie" <Natalie.Protasevich@unisys.com>,
       linux-kernel@vger.kernel.org, Arjan van de Ven <arjan@infradead.org>
References: <m1irl4ftya.fsf@ebiederm.dsl.xmission.com> <200608080801.29789.ak@suse.de> <m1lkpz9134.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m1lkpz9134.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200608080848.03054.ak@suse.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> >
> > However not that particular patch - i already changed that
> > code in my tree because I needed really early per cpu for something and
> > i had switched to using a static array for cpu0's cpudata.
> >
> > I will modify it to work like your proposal.
> 
> Sounds good to me.

Actually i ended up going with your patch and dropping mine
because of some other issues and I solved the problem
that caused me to do the other in a different way.

-Andi

