Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262211AbUBXImf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 03:42:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262206AbUBXImf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 03:42:35 -0500
Received: from gate.crashing.org ([63.228.1.57]:22963 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262211AbUBXIlY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 03:41:24 -0500
Subject: Re: [Linux-fbdev-devel] Re: fbdv/fbcon pending problems
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: James Simmons <jsimmons@infradead.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.GSO.4.58.0402240936270.3187@waterleaf.sonytel.be>
References: <Pine.LNX.4.44.0402231823570.11599-100000@phoenix.infradead.org>
	 <1077576644.5960.77.camel@gaston>
	 <Pine.GSO.4.58.0402240936270.3187@waterleaf.sonytel.be>
Content-Type: text/plain
Message-Id: <1077611593.28488.162.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 24 Feb 2004 19:33:13 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> What about renaming it to FB_ACTIVE_RESIZE?

Because it's not actually setting any mode, just returns a
valid "var" :) For now, fbcon will just do a set_var
FB_ACTIVATE_NOW right away, but userland may want to use
that to build mode lists without actually changing the mode...

Ben.


