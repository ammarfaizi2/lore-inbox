Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261313AbTC0T03>; Thu, 27 Mar 2003 14:26:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261328AbTC0T03>; Thu, 27 Mar 2003 14:26:29 -0500
Received: from rth.ninka.net ([216.101.162.244]:56476 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id <S261313AbTC0T01>;
	Thu, 27 Mar 2003 14:26:27 -0500
Subject: Re: [PATCH] asm offsets for i386
From: "David S. Miller" <davem@redhat.com>
To: Brian Gerst <bgerst@didntduck.org>
Cc: Pete Zaitcev <zaitcev@redhat.com>, linux-kernel@vger.kernel.org
In-Reply-To: <3E833EDD.9050007@didntduck.org>
References: <mailman.1048773360.3585.linux-kernel2news@redhat.com>
	 <200303271728.h2RHSDc28540@devserv.devel.redhat.com>
	 <3E833EDD.9050007@didntduck.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1048793857.20907.0.camel@rth.ninka.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 27 Mar 2003 11:37:38 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-03-27 at 10:11, Brian Gerst wrote:
> I already caught one bug with this, since someone recently added values 
> to the feature flags array and didn't fix up the vendor id offset.  What 
> you propose fails with some non-gcc compilers (Intel's compiler for 
> example, which supports gcc extensions) that don't optimize it away.

Too f*ing bad, this kind of debug test already exists in other
places of the kernel.

-- 
David S. Miller <davem@redhat.com>
