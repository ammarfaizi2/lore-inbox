Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267783AbTGIBML (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 21:12:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268044AbTGIBML
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 21:12:11 -0400
Received: from air-2.osdl.org ([65.172.181.6]:7638 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267783AbTGIBLg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 21:11:36 -0400
Date: Tue, 8 Jul 2003 18:26:20 -0700
From: Andrew Morton <akpm@osdl.org>
To: herbert@13thfloor.at
Cc: arvidjaar@mail.ru, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.5.74] devfs lookup deadlock/stack corruption combined
 patch
Message-Id: <20030708182620.590edd06.akpm@osdl.org>
In-Reply-To: <20030709012014.GA19777@www.13thfloor.at>
References: <E198K0q-000Am8-00.arvidjaar-mail-ru@f23.mail.ru>
	<200307072306.15995.arvidjaar@mail.ru>
	<20030707140010.4268159f.akpm@osdl.org>
	<200307082149.17918.arvidjaar@mail.ru>
	<20030709012014.GA19777@www.13thfloor.at>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Poetzl <herbert@13thfloor.at> wrote:
>
> On Tue, Jul 08, 2003 at 09:49:17PM +0400, Andrey Borzenkov wrote:
> > 
> > I do not want to sound like it has to be ignored - but devfs code is so messy 
> > that no trivial fix exists that would not make code even more messy. So I 
> 
> sorry to interrupt, but wasn't there an ongoing
> efford to replace the devfs with smalldevfs or 
> something even better? *hint*
> 

Yes, but

a) It didn't have a compatible solution for the legacy device names
   (/dev/hda, etc).  Could have been fixed up in userspace but the work was
   not done.

b) Certain parties youknowwhoyouare seem to have been stricken by smalldevfs
   amnesia.

I'm hoping that smalldevfs comes back.  The current thing is a running
sore.

