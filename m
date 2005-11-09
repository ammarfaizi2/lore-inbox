Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161295AbVKIWHu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161295AbVKIWHu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 17:07:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161288AbVKIWHt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 17:07:49 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:23009 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1161286AbVKIWHs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 17:07:48 -0500
Subject: Re: [PATCH] ppc64: 64K pages support
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Mike Kravetz <kravetz@us.ibm.com>, Christoph Hellwig <hch@lst.de>,
       Andrew Morton <akpm@osdl.org>,
       linuxppc64-dev <linuxppc64-dev@ozlabs.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <1131573693.24637.109.camel@gaston>
References: <1130915220.20136.14.camel@gaston>
	 <1130916198.20136.17.camel@gaston> <20051109172125.GA12861@lst.de>
	 <20051109201720.GB5443@w-mikek2.ibm.com> <1131568336.24637.91.camel@gaston>
	 <1131573556.25354.1.camel@localhost.localdomain>
	 <1131573693.24637.109.camel@gaston>
Content-Type: text/plain
Date: Wed, 09 Nov 2005 14:07:31 -0800
Message-Id: <1131574051.25354.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-11-10 at 09:01 +1100, Benjamin Herrenschmidt wrote:
> > I didn't have any luck on 2.6.14-git12 either.
> > I tried 64k page support on my P570. 
> > 
> > Here are the console messages:
> 
> What distro do you use in userland ? Some older glibc versions have a
> bug that cause issues with 64k pages, though it generally happens with
> login blowing up, not init ...

SLES9 (could be SLES9 SP1).

Thanks,
Badari

