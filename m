Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262956AbUDEAJR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Apr 2004 20:09:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262966AbUDEAJR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Apr 2004 20:09:17 -0400
Received: from gate.crashing.org ([63.228.1.57]:54438 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262956AbUDEAJB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Apr 2004 20:09:01 -0400
Subject: Re: [PANIC] ohci1394 & copy large files
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ben Collins <bcollins@debian.org>
Cc: Marcel Lanz <marcel.lanz@ds9.ch>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20040404231746.GX13168@phunnypharm.org>
References: <20040404141600.GB10378@ds9.ch>
	 <20040404141339.GW13168@phunnypharm.org> <1081119623.1285.121.camel@gaston>
	 <20040404231746.GX13168@phunnypharm.org>
Content-Type: text/plain
Message-Id: <1081123676.1203.128.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 05 Apr 2004 10:07:56 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-04-05 at 09:17, Ben Collins wrote:

> Because the fix was pretty extensive and needed testing. It was
> potentially more broken that the problem it was fixing. Sending untested
> patches to Linus is far worse than batching a few up and pushing to him.

Ok, makes sense, it wasn't just a 1-liner quick fix then ;)

Still, from my experience, _very few_ people actually test things in
trees like ieee1394, fbdev, etc...  Even my tree isn't what it used
to be for pmacs now that I'm fully in sync upstream.

Even -mm lately haven't been as tested as it used to be (possibly
because of upstream getting better). I find it's quite ok to send
a fix that needs a bit more testing to a Linus -rc1 (but not later),

Ben.



