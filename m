Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270729AbTG0K7J (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 06:59:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270731AbTG0K7I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 06:59:08 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:51075
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S270729AbTG0K7E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 06:59:04 -0400
Subject: Re: [PATCH] Remove module reference counting.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Aschwin Marsman <a.marsman@aYniK.com>
Cc: Arjan van de Ven <arjanv@redhat.com>, Linus Torvalds <torvalds@osdl.org>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Stephen Hemminger <shemminger@osdl.org>,
       "David S. Miller" <davem@redhat.com>, Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0307270735360.2141-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0307270735360.2141-100000@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1059304217.12759.16.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 27 Jul 2003 12:10:18 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2003-07-27 at 06:38, Aschwin Marsman wrote:
> But doesn't the same happen when e.g. kudzu tries to detect new hardware?
> This is running every time my RH system boots, so memory leaks at that 
> moment do not appeal to me. When it's only an installer thing, it doesn't
> worry me, although from an engineering perspective...

Yes - and also every time you trigger some of the USB firmware loading
modules and the like you'd lose 200K or so

