Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271854AbTG2RCS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 13:02:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271883AbTG2RCS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 13:02:18 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:23813 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S271854AbTG2RCP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 13:02:15 -0400
Date: Tue, 29 Jul 2003 18:02:09 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: Petr Vandrovec <vandrove@vc.cvut.cz>
cc: =?iso-8859-2?B?RnLpZOlyaWMgTC4gVy4=?= Meunier <0@pervalidus.tk>,
       <linux-kernel@vger.kernel.org>
Subject: Re: matroxfb and 2.6.0-test2
In-Reply-To: <20030729021321.GA1282@vana.vc.cvut.cz>
Message-ID: <Pine.LNX.4.44.0307291801150.5874-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > After it the screen became corrupted with a dump of my last
> > shutdown. All commands still worked. I don't use fbset at all.
> > The logs don't have anything about matroxfb.
> 
> Try building matroxfb into the kernel. I believe that current VT system
> does not take over console anymore if fbdev is loaded after fbcon, but
> I never tested it myself.

Correct. You need run con2fb if you load a fbdev driver after fbcon.c. 
This maps the framebuffer to the console.



