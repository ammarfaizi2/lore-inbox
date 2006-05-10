Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750880AbWEJQhW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750880AbWEJQhW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 12:37:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965016AbWEJQhW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 12:37:22 -0400
Received: from [63.81.120.158] ([63.81.120.158]:28892 "EHLO
	gateway-1237.mvista.com") by vger.kernel.org with ESMTP
	id S1750880AbWEJQhV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 12:37:21 -0400
Subject: Re: [PATCH -mm] sys_semctl gcc 4.1 warning fix
From: Daniel Walker <dwalker@mvista.com>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060510162106.GC27946@ftp.linux.org.uk>
References: <200605100256.k4A2u8bd031779@dwalker1.mvista.com>
	 <1147257266.17886.3.camel@localhost.localdomain>
	 <1147271489.21536.70.camel@c-67-180-134-207.hsd1.ca.comcast.net>
	 <1147273787.17886.46.camel@localhost.localdomain>
	 <1147273598.21536.92.camel@c-67-180-134-207.hsd1.ca.comcast.net>
	 <1147275571.17886.64.camel@localhost.localdomain>
	 <1147275522.21536.109.camel@c-67-180-134-207.hsd1.ca.comcast.net>
	 <20060510162106.GC27946@ftp.linux.org.uk>
Content-Type: text/plain
Date: Wed, 10 May 2006 09:37:18 -0700
Message-Id: <1147279038.21536.120.camel@c-67-180-134-207.hsd1.ca.comcast.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-05-10 at 17:21 +0100, Al Viro wrote:

> Don't.  Fix.  Correct.  Code.
> 
> Ever.  Because sooner or later you will paper over real bug.  It's far better
> to reject patches that just make $TOOL to STFU than risk blind "fix" hiding
> a real bug.

Couldn't agree with you more .. But I don't want to see the warning
either ..

> Unless you show a real codepath that leads to use without initialization
> (and do that in commit message, so it could be verified as real issue),
> these patches are worthless in the best case and dangerous in the worst
> one.

Several of my patches have nothing to do with initialization .. 

Daniel

