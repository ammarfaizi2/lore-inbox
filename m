Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265171AbTABQsX>; Thu, 2 Jan 2003 11:48:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265262AbTABQsX>; Thu, 2 Jan 2003 11:48:23 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:9608
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S265171AbTABQsW>; Thu, 2 Jan 2003 11:48:22 -0500
Subject: Re: [PATCH] Modules 3/3: Sort sections
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "David S. Miller" <davem@redhat.com>
Cc: rth@twiddle.net, rusty@rustcorp.com.au,
       Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       schwidefsky@de.ibm.com, ak@suse.de, paulus@samba.org,
       rmk@arm.linux.org.uk
In-Reply-To: <20030101.211536.121172392.davem@redhat.com>
References: <20030101205404.B30272@twiddle.net>
	<20030101.205003.37279830.davem@redhat.com>
	<20030101205836.A30574@twiddle.net> 
	<20030101.211536.121172392.davem@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 02 Jan 2003 17:39:17 +0000
Message-Id: <1041529157.24829.15.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-01-02 at 05:15, David S. Miller wrote:
>    Obviously.  Perhaps the question was worded badly.  Instead read
>    it as "Why don't we force this to be called .init.foo instead?"
> 
> This new naming order was created recently, but I forget the reason.
> It used to be .init.foo

Because of -ffunction-sections usage


