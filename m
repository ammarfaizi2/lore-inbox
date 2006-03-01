Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750768AbWCAMiE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750768AbWCAMiE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 07:38:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750795AbWCAMiD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 07:38:03 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:2495 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750768AbWCAMiB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 07:38:01 -0500
Subject: Re: [RFC] vfs: cleanup of permission()
From: Arjan van de Ven <arjan@infradead.org>
To: tvrtko.ursulin@sophos.com
Cc: Herbert Poetzl <herbert@13thfloor.at>, Andrew Morton <akpm@osdl.org>,
       Christoph Hellwig <hch@infradead.org>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>,
       Al Viro <viro@ftp.linux.org.uk>
In-Reply-To: <OFAFEC22B7.7F7518A9-ON80257124.0043AF58-80257124.00448503@sophos.com>
References: <OFAFEC22B7.7F7518A9-ON80257124.0043AF58-80257124.00448503@sophos.com>
Content-Type: text/plain
Date: Wed, 01 Mar 2006 13:37:51 +0100
Message-Id: <1141216671.3185.22.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> And finally, please don't remove nameidata. Modules out there depend on it 

are those modules about to merged into the kernel? The current intent
infrastructure isn't fulfilling what it should do well, and from what
I've seen on the discussions it sounds that the best way forward is to
undo the current implementation and then roll out one which caters to
the needs of the existing users better.

As external module, you have little say so far simply because your usage
isn't visible. I'd urge you to quickly submit your code so that the
things you need from this are better visible to the people who are
thinking and working on the redesign.

> and we at Sophos are about to release a new product which needs it as 
> well. 

I assume we're talking about an open source product, or at least kernel
component, here?


