Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263517AbTKWX0Y (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Nov 2003 18:26:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263524AbTKWX0Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Nov 2003 18:26:24 -0500
Received: from pizda.ninka.net ([216.101.162.242]:10123 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S263517AbTKWX0X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Nov 2003 18:26:23 -0500
Date: Sun, 23 Nov 2003 15:26:01 -0800
From: "David S. Miller" <davem@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: anand@eis.iisc.ernet.in, linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: 2.6.0-test9 : bridge freezes
Message-Id: <20031123152601.67646dc1.davem@redhat.com>
In-Reply-To: <Pine.LNX.4.44.0311220819260.2379-100000@home.osdl.org>
References: <200311221527.UAA29684@eis.iisc.ernet.in>
	<Pine.LNX.4.44.0311220819260.2379-100000@home.osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 Nov 2003 08:20:40 -0800 (PST)
Linus Torvalds <torvalds@osdl.org> wrote:

> On Sat, 22 Nov 2003, SVR Anand wrote:
> > 
> > The problem is : After 3 to 4 hours of functioning, the bridge stops working 
> > and the machine becomes unusable where it doesn't respond to keyboard, and 
> > there is no video display.
> 
> Sounds like a memory leak somewhere. It would probably be interesting to 
> watch /proc/slabinfo every five minutes or so, and see what happens..

Also, we've certainly fixed some serious networking bugs since test9
came out.
