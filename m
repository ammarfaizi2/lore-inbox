Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754330AbWKRKRl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754330AbWKRKRl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Nov 2006 05:17:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754331AbWKRKRl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Nov 2006 05:17:41 -0500
Received: from mail.suse.de ([195.135.220.2]:11463 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1754329AbWKRKRk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Nov 2006 05:17:40 -0500
From: Andi Kleen <ak@suse.de>
To: vgoyal@in.ibm.com
Subject: Re: [RFC][PATCH 0/20] x86_64: Relocatable bzImage (V3)
Date: Sat, 18 Nov 2006 09:52:02 +0100
User-Agent: KMail/1.9.5
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Reloc Kernel List <fastboot@lists.osdl.org>, ebiederm@xmission.com,
       akpm@osdl.org, hpa@zytor.com, magnus.damm@gmail.com, lwang@redhat.com,
       dzickus@redhat.com, pavel@suse.cz, rjw@sisk.pl
References: <20061117223432.GA15449@in.ibm.com>
In-Reply-To: <20061117223432.GA15449@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611180952.02722.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> - Fixed a bug during resume operation on machines which support NX bit.
> 
> Your comments/suggestions are welcome.

The patches mostly look good to me. Lots of valuable cleanups too.

But they are clearly .21 material, needing much more testing.

I don't want to merge them before I have the .20 queue flushed
because merging them right now would cause too much patch churn 
I think and it's better to do that once the main flood of .20
patches is gone. So I would like to delay merging a bit until
that happened.

Is that ok for you?

-Andi
