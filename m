Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262110AbUC1RHb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Mar 2004 12:07:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262130AbUC1RHb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Mar 2004 12:07:31 -0500
Received: from mxsf08.cluster1.charter.net ([209.225.28.208]:2573 "EHLO
	mxsf08.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S262110AbUC1RH2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Mar 2004 12:07:28 -0500
Subject: Re: 2.6.5-rc2-mm[34] causes drop in DRI FPS
From: Glenn Johnson <glennpj@charter.net>
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
Cc: Kernel <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <200403281830.12976@WOLK>
References: <1080435375.8280.1.camel@gforce.johnson.home>
	 <20040328090637.GA11056@elte.hu>
	 <1080490657.9667.7.camel@gforce.johnson.home>  <200403281830.12976@WOLK>
Content-Type: text/plain
Message-Id: <1080493275.7969.2.camel@gforce.johnson.home>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 28 Mar 2004 11:01:15 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-03-28 at 10:30, Marc-Christian Petersen wrote:
> On Sunday 28 March 2004 18:17, Glenn Johnson wrote:
> 
> Hi Glenn,
> 
> > > > > It could be the AGP changes.  Please do a `patch -p1 -R' of
> > > > > bk-agpgart.patch and retest?
> > > > I reverted that patch and retested but it did not solve the problem. I
> > > > am still only seeing about 180 fps with glxgears.
> > > what does 'glxinfo | grep rendering' show?
> 
> what about reverting "DRM-cvs-update.patch"?

I have not tried that but has that patch been in the tree for some time
now? My DRI works fine with 2.6.5-rc2-mm2, which has that patch.

--
Glenn Johnson
glennpj@charter.net

