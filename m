Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270735AbTG0K6N (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 06:58:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270737AbTG0K6N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 06:58:13 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:49283
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S270735AbTG0K6M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 06:58:12 -0400
Subject: Re: [PATCH] Remove module reference counting.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Rusty Russell <rusty@rustcorp.com.au>,
       Stephen Hemminger <shemminger@osdl.org>,
       "David S. Miller" <davem@redhat.com>, Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030726193743.B20667@devserv.devel.redhat.com>
References: <20030726172139.348342C24B@lists.samba.org>
	 <Pine.LNX.4.44.0307261230110.1841-100000@home.osdl.org>
	 <20030726193743.B20667@devserv.devel.redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1059304166.12759.14.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 27 Jul 2003 12:09:26 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2003-07-26 at 20:37, Arjan van de Ven wrote:
> > It's not just a developer thing. At least installers etc used to do some 
> > device probing by loading modules and depending on the result.
> 
> yes but those same installers couldn't care less if the kernel
> completely frees the memory of the module text or if it leaks that.
> It won't even notice the difference....

On a 64Mb box the Red Hat installer would crash in this situation if you
do the maths

