Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751100AbWHBDLA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751100AbWHBDLA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 23:11:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751097AbWHBDKn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 23:10:43 -0400
Received: from mail.suse.de ([195.135.220.2]:7145 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751100AbWHBDKj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 23:10:39 -0400
From: Andi Kleen <ak@suse.de>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH 18/33] x86_64: Kill temp_boot_pmds II
Date: Wed, 2 Aug 2006 05:07:02 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org, Horms <horms@verge.net.au>,
       Jan Kratochvil <lace@jankratochvil.net>,
       "H. Peter Anvin" <hpa@zytor.com>, Magnus Damm <magnus.damm@gmail.com>,
       Vivek Goyal <vgoyal@in.ibm.com>, Linda Wang <lwang@redhat.com>
References: <m1d5bk2046.fsf@ebiederm.dsl.xmission.com> <p73psfk1dnh.fsf_-_@verdi.suse.de> <m18xm7yjh7.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m18xm7yjh7.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608020507.02604.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> It is probably patch 17:
> "x86_64: Separate normal memory map initialization from the hotplug case"

Ok that messes things up. Actually I think i prefered the previous
code - it was not that bad as you make it. The two variants. 
are really doing mostly the same. So best you drop that.

> I don't see any other patches that touch arch/x86_64/mm/init.c
> before that.  At least not in 2.6.18-rc3, which is the base of
> my patchset.

I got three patches that touch mm/init.c in my patchkit
(ftp://ftp.firstfloor.org/pub/ak/x86_64/quilt/patches/)

BTW I didn't merge any further patches currently, but might
after the next round when the current comments are addressed.

-Andi

