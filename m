Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272450AbTG0Wyj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 18:54:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272381AbTG0WyW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 18:54:22 -0400
Received: from zeus.kernel.org ([204.152.189.113]:51698 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S272389AbTG0WyO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 18:54:14 -0400
Date: Sun, 27 Jul 2003 21:47:01 +0000
From: Arjan van de Ven <arjanv@redhat.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Stephen Hemminger <shemminger@osdl.org>,
       "David S. Miller" <davem@redhat.com>, arjanv@redhat.com,
       Greg KH <greg@kroah.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Remove module reference counting.
Message-ID: <20030727214701.A23137@devserv.devel.redhat.com>
References: <Pine.LNX.4.44.0307261230110.1841-100000@home.osdl.org> <20030727193919.832302C450@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030727193919.832302C450@lists.samba.org>; from rusty@rustcorp.com.au on Mon, Jul 28, 2003 at 05:34:36AM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 28, 2003 at 05:34:36AM +1000, Rusty Russell wrote:
> 
> The kudzu one and Alan's USB firmware example bother me more: they
> load then unload modules currently? 

I'm pretty sure kudzu doesn't
