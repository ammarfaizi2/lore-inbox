Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261942AbUC1QTe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Mar 2004 11:19:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261947AbUC1QTe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Mar 2004 11:19:34 -0500
Received: from mxsf02.cluster1.charter.net ([209.225.28.202]:46095 "EHLO
	mxsf02.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S261942AbUC1QTa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Mar 2004 11:19:30 -0500
Subject: Re: 2.6.5-rc2-mm[34] causes drop in DRI FPS
From: Glenn Johnson <glennpj@charter.net>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040328090637.GA11056@elte.hu>
References: <1080435375.8280.1.camel@gforce.johnson.home>
	 <20040327180932.10e4bae7.akpm@osdl.org>
	 <1080443802.7085.2.camel@gforce.johnson.home>
	 <20040328090637.GA11056@elte.hu>
Content-Type: text/plain
Message-Id: <1080490657.9667.7.camel@gforce.johnson.home>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 28 Mar 2004 10:17:43 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-03-28 at 03:06, Ingo Molnar wrote:

> * Glenn Johnson <glennpj@charter.net> wrote:
> 
> > > It could be the AGP changes.  Please do a `patch -p1 -R' of
> > > bk-agpgart.patch and retest?
> > 
> > I reverted that patch and retested but it did not solve the problem. I
> > am still only seeing about 180 fps with glxgears.
> 
> what does 'glxinfo | grep rendering' show?

It shows:

        direct rendering: Yes
        
I had checked that first thing. I also verified that the AGPgart
detected the chipset, etc. Everything seems okay in the XFree86 log file
as well.

--
Glenn Johnson
glennpj@charter.net

