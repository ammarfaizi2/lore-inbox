Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262440AbTIHNjN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 09:39:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262399AbTIHNjG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 09:39:06 -0400
Received: from pub237.cambridge.redhat.com ([213.86.99.237]:28110 "EHLO
	executor.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id S262440AbTIHNi0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 09:38:26 -0400
Subject: Re: kernel header separation
From: David Woodhouse <dwmw2@infradead.org>
To: Matthew Wilcox <willy@debian.org>
Cc: Erik Andersen <andersen@codepoet.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20030905232212.GP18654@parcelfarce.linux.theplanet.co.uk>
References: <20030902191614.GR13467@parcelfarce.linux.theplanet.co.uk>
	 <20030903014908.GB1601@codepoet.org>
	 <20030905144154.GL18654@parcelfarce.linux.theplanet.co.uk>
	 <20030905211604.GB16993@codepoet.org>
	 <20030905232212.GP18654@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain
Message-Id: <1063028303.32473.333.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.5 (dwmw2) 
Date: Mon, 08 Sep 2003 14:38:23 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-09-06 at 00:22 +0100, Matthew Wilcox wrote:
> On Fri, Sep 05, 2003 at 03:16:04PM -0600, Erik Andersen wrote:
> > On Fri Sep 05, 2003 at 03:41:54PM +0100, Matthew Wilcox wrote:
> > > i think all these _t types are ugly ;-(
> > 
> > They may be ugly, but they are standardized and have very 
> > precise meanings defined by ISO C99, which is a very good
> > thing for code interoperability...
> 
> __u8 has a very precise meaning defined by Linux.  If you're including
> a Linux header. that's what you need to worry about.

It's a kernel-private type. If we're aiming for a clean set of headers,
then ideally we should avoid gratuitously defining our own types when
standards already exist.

-- 
dwmw2

