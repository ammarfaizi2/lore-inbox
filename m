Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264305AbTDKHvG (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 03:51:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264314AbTDKHvG (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 03:51:06 -0400
Received: from AMarseille-201-1-6-197.abo.wanadoo.fr ([80.11.137.197]:9511
	"EHLO zion.wanadoo.fr") by vger.kernel.org with ESMTP
	id S264305AbTDKHvG (for <rfc822;linux-kernel@vger.kernel.org>); Fri, 11 Apr 2003 03:51:06 -0400
Subject: Re: [PATCH] New radeonfb fork
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Daniele Venzano <webvenza@libero.it>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030410211302.GA720@renditai.milesteg.arr>
References: <1049642954.550.41.camel@zion.wanadoo.fr>
	 <20030410084650.GA728@renditai.milesteg.arr>
	 <1049984776.555.90.camel@zion.wanadoo.fr>
	 <20030410211302.GA720@renditai.milesteg.arr>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1050048284.572.17.camel@zion.wanadoo.fr>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 11 Apr 2003 10:04:45 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-04-10 at 23:13, Daniele Venzano wrote:

> There's very little difference, but I was expecting to get the same
> mode. I'll go read how that modedb stuff works...

The mode asked during boot comes from the in-kernel modedb,
the mode passed in by fbset comes from fbset own files
/etc/fb.modes

This is not very consistent, I hope /etc/fb.modes can be
deprecated one day once we have proper mode management in
the kernel, something Tony Dapalas have been working on
lately.


Ben.

