Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751515AbWEJWaV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751515AbWEJWaV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 18:30:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751514AbWEJWaV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 18:30:21 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:65247
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751511AbWEJWaU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 18:30:20 -0400
Date: Wed, 10 May 2006 15:30:07 -0700 (PDT)
Message-Id: <20060510.153007.19037157.davem@davemloft.net>
To: akpm@osdl.org
Cc: viro@ftp.linux.org.uk, dwalker@mvista.com, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH -mm] sys_semctl gcc 4.1 warning fix
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20060510150321.11262b24.akpm@osdl.org>
References: <1147275522.21536.109.camel@c-67-180-134-207.hsd1.ca.comcast.net>
	<20060510162106.GC27946@ftp.linux.org.uk>
	<20060510150321.11262b24.akpm@osdl.org>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Morton <akpm@osdl.org>
Date: Wed, 10 May 2006 15:03:21 -0700

> I occasionally receive patches which generate new warnings, and those
> warnings flag real bugs.  The developer simply missing the warning amongst
> all the other crap.

I totally agree.  These gcc-4.x warnings bug this shit out of
me too and we should fix them now.

Even a huge tree like gcc can build itself %100 fine with -Werror, for
pretty much every configuration possible, and yet we're astronomically
so far away from that.  That's totally unacceptable.
