Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030386AbVKIWD2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030386AbVKIWD2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 17:03:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161281AbVKIWDZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 17:03:25 -0500
Received: from gate.crashing.org ([63.228.1.57]:49070 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1030789AbVKIWDU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 17:03:20 -0500
Subject: Re: [PATCH] ppc64: 64K pages support
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: Mike Kravetz <kravetz@us.ibm.com>, Christoph Hellwig <hch@lst.de>,
       Andrew Morton <akpm@osdl.org>,
       linuxppc64-dev <linuxppc64-dev@ozlabs.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <1131573556.25354.1.camel@localhost.localdomain>
References: <1130915220.20136.14.camel@gaston>
	 <1130916198.20136.17.camel@gaston> <20051109172125.GA12861@lst.de>
	 <20051109201720.GB5443@w-mikek2.ibm.com> <1131568336.24637.91.camel@gaston>
	 <1131573556.25354.1.camel@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 10 Nov 2005 09:01:32 +1100
Message-Id: <1131573693.24637.109.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I didn't have any luck on 2.6.14-git12 either.
> I tried 64k page support on my P570. 
> 
> Here are the console messages:

What distro do you use in userland ? Some older glibc versions have a
bug that cause issues with 64k pages, though it generally happens with
login blowing up, not init ...

Ben.


