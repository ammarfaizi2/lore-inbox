Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263185AbUA0KW1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 05:22:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263303AbUA0KW0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 05:22:26 -0500
Received: from gate.crashing.org ([63.228.1.57]:26082 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S263185AbUA0KW0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 05:22:26 -0500
Subject: Re: [Linux-fbdev-devel] Re: monochrome display fix.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Cc: Linus Torvalds <torvalds@osdl.org>, James Simmons <jsimmons@infradead.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040127074035.GF1315@rembrandt.csv.ica.uni-stuttgart.de>
References: <Pine.LNX.4.44.0401262212140.5445-100000@phoenix.infradead.org>
	 <Pine.LNX.4.58.0401261446560.2313@home.osdl.org>
	 <20040127074035.GF1315@rembrandt.csv.ica.uni-stuttgart.de>
Content-Type: text/plain
Message-Id: <1075198769.30623.187.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 27 Jan 2004 21:19:29 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> It was always broken. This went unnoticed, apparently nobody tried to use
> a kernel which supports mono and colour framebuffers at the same time.

Still, the patch is ugly.. I'd rather just calculate the colour
normally, and only conditionally store it once in the end...

Ben.


