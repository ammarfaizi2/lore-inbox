Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272874AbTHKR1h (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 13:27:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272898AbTHKR13
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 13:27:29 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:527 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S272874AbTHKRZD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 13:25:03 -0400
Date: Mon, 11 Aug 2003 18:25:00 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: Ludovic Drolez <ludovic.drolez@freealter.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: keep the linux logo displayed
In-Reply-To: <3F378FC3.1020507@freealter.com>
Message-ID: <Pine.LNX.4.44.0308111823400.2275-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > 	You can write a userland app to do this. There are esc sequence 
> > that change vc_top. You could even alter minigetty if you want.
> 
> Many thanks for the esc sequence hint !
> But it seems there's something broken with it: if I send 'esc[10;20r'
> - the scrolling region is now between lines 10 and 20

Seem right with the esc you used.

> - but, the cursor is moved to 0,0 instead of line 10

Hum. I have to look into that. 

> - and the linux logo does not appear...

Bug. Fixed in the latest kernel.


> 
> Bug or feature ??
> 
> 

