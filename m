Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261959AbUC1QbE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Mar 2004 11:31:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261981AbUC1QbD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Mar 2004 11:31:03 -0500
Received: from lindsey.linux-systeme.com ([62.241.33.80]:33552 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S261959AbUC1QbB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Mar 2004 11:31:01 -0500
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.5-rc2-mm[34] causes drop in DRI FPS
Date: Sun, 28 Mar 2004 18:30:12 +0200
User-Agent: KMail/1.6.1
Cc: Glenn Johnson <glennpj@charter.net>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>
References: <1080435375.8280.1.camel@gforce.johnson.home> <20040328090637.GA11056@elte.hu> <1080490657.9667.7.camel@gforce.johnson.home>
In-Reply-To: <1080490657.9667.7.camel@gforce.johnson.home>
X-Operating-System: Linux 2.6.4-wolk2.3 i686 GNU/Linux
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200403281830.12976@WOLK>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 28 March 2004 18:17, Glenn Johnson wrote:

Hi Glenn,

> > > > It could be the AGP changes.  Please do a `patch -p1 -R' of
> > > > bk-agpgart.patch and retest?
> > > I reverted that patch and retested but it did not solve the problem. I
> > > am still only seeing about 180 fps with glxgears.
> > what does 'glxinfo | grep rendering' show?

what about reverting "DRM-cvs-update.patch"?

ciao, Marc
