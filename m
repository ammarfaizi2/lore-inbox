Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268011AbUHXPd6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268011AbUHXPd6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 11:33:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267992AbUHXPd6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 11:33:58 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:27853 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S268017AbUHXPdt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 11:33:49 -0400
Date: Tue, 24 Aug 2004 17:33:43 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: John Cherry <cherry@osdl.org>, "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org, sds@epoch.ncsc.mil, jmorris@redhat.com
Subject: 2.6.9-rc1: selinux/hooks.c: functions returning unassigned variables
Message-ID: <20040824153342.GG7019@fs.tum.de>
References: <200408241519.i7OFJS6S027910@cherrypit.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408241519.i7OFJS6S027910@cherrypit.pdx.osdl.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 24, 2004 at 08:19:28AM -0700, John Cherry wrote:
>...
> security/selinux/hooks.c:2825: warning: `ret' might be used uninitialized in this function
> security/selinux/hooks.c:2886: warning: `ret' might be used uninitialized in this function


This was
  [NET]: Add skb_header_pointer, and use it where possible.


@Dave:
In both functions ret is returned, but line that assigned a value to ret 
was removed.

*shrug*


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

