Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271508AbTGQROa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 13:14:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271511AbTGQROa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 13:14:30 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:20999 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S271508AbTGQRO3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 13:14:29 -0400
Date: Thu, 17 Jul 2003 18:29:21 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: Eric Blade <eblade@blackmagik.dynup.net>
cc: petero2@telia.com, <linux-kernel@vger.kernel.org>
Subject: Re: radeonfb patch for 2.4.22...
In-Reply-To: <3F152FF7.5000309@blackmagik.dynup.net>
Message-ID: <Pine.LNX.4.44.0307171827260.10255-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> This has been happening to me on my Radeon and on my Voodoo 3 for as 
> long as there has been framebuffers and they have in fact compiled and 
> worked.  I thought this was normal?

Its caused from switching from text mode to graphics mode. Take for 
example I have grabbed th epci regions for my voodoo card and then wrote 
to them. This was done before I switched to graphics mode. It messed up my 
vga text screen. So when we go from text to graphics we have stale data. 


