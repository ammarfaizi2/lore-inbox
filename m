Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318892AbSIIUuu>; Mon, 9 Sep 2002 16:50:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318898AbSIIUut>; Mon, 9 Sep 2002 16:50:49 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:61167
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318892AbSIIUur>; Mon, 9 Sep 2002 16:50:47 -0400
Subject: Re: [PATCH] Important per-cpu fix.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "David S. Miller" <davem@redhat.com>
Cc: rusty@rustcorp.com.au, pavel@suse.cz,
       Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
       akpm@zip.com.au
In-Reply-To: <20020909.011539.122194350.davem@redhat.com>
References: <20020908.231304.30400540.davem@redhat.com>
	<20020909081754.EC8382C09D@lists.samba.org> 
	<20020909.011539.122194350.davem@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-6) 
Date: 09 Sep 2002 21:58:06 +0100
Message-Id: <1031605086.29718.43.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-09-09 at 09:15, David S. Miller wrote:
> Note that Andrew Morton found the problem on one of his older
> x86 EGCS's about the same time I found it on sparc64.

egcs gets so many long long things wrong on x86 that its only valid use
IMHO for 2.5 is as a syntax checker. Is it really worth an ugly hack for
a compiler one major developer has a personal affliction for and a port
that has a tiny user base and now has a working compiler.

Maybe if we put less gunk in the kernel they'd fix gcc more often 8)

