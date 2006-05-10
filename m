Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964961AbWEJWGQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964961AbWEJWGQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 18:06:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965036AbWEJWGQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 18:06:16 -0400
Received: from smtp.osdl.org ([65.172.181.4]:24451 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964961AbWEJWGP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 18:06:15 -0400
Date: Wed, 10 May 2006 15:03:21 -0700
From: Andrew Morton <akpm@osdl.org>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: dwalker@mvista.com, alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -mm] sys_semctl gcc 4.1 warning fix
Message-Id: <20060510150321.11262b24.akpm@osdl.org>
In-Reply-To: <20060510162106.GC27946@ftp.linux.org.uk>
References: <200605100256.k4A2u8bd031779@dwalker1.mvista.com>
	<1147257266.17886.3.camel@localhost.localdomain>
	<1147271489.21536.70.camel@c-67-180-134-207.hsd1.ca.comcast.net>
	<1147273787.17886.46.camel@localhost.localdomain>
	<1147273598.21536.92.camel@c-67-180-134-207.hsd1.ca.comcast.net>
	<1147275571.17886.64.camel@localhost.localdomain>
	<1147275522.21536.109.camel@c-67-180-134-207.hsd1.ca.comcast.net>
	<20060510162106.GC27946@ftp.linux.org.uk>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Viro <viro@ftp.linux.org.uk> wrote:
>
> Don't.  Fix.  Correct.  Code.
> 
>  Ever.  Because sooner or later you will paper over real bug.

I occasionally receive patches which generate new warnings, and those
warnings flag real bugs.  The developer simply missing the warning amongst
all the other crap.

It seems to especialy affect ia64 developers, whose build is especially
noisy.
