Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263741AbTEFNyk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 09:54:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263745AbTEFNyB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 09:54:01 -0400
Received: from rth.ninka.net ([216.101.162.244]:52176 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id S263741AbTEFNxA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 09:53:00 -0400
Subject: Re: [PATCH] 2.4.21-rc1: byteorder.h breaks with __STRICT_ANSI__
	defined (trivial)
From: "David S. Miller" <davem@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Thomas Horsten <thomas@horsten.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20030506104956.A29357@infradead.org>
References: <20030506103823.B27816@infradead.org>
	 <Pine.LNX.4.40.0305061146050.8287-100000@jehova.dsm.dk>
	 <20030506104956.A29357@infradead.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1052215397.983.25.camel@rth.ninka.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 06 May 2003 03:03:18 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-05-06 at 02:49, Christoph Hellwig wrote:
> > In any case, if the __STRICT_ANSI__ conditional is there in types.h, it
> > should be there in byteorder.h as well.
> 
> I don't agree with you in principle, but as this is 2.4 it's probably
> better to just add it.  Would you mind sending Marcelo a patch?

What if one of these "used from userland anyways" headers needs
the 64-bit swabs?

This is why I'm so against this patch.

-- 
David S. Miller <davem@redhat.com>
