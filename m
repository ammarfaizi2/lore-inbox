Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750797AbWECUXL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750797AbWECUXL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 16:23:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750810AbWECUXK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 16:23:10 -0400
Received: from fep32-0.kolumbus.fi ([193.229.0.63]:22934 "EHLO
	fep32-app.kolumbus.fi") by vger.kernel.org with ESMTP
	id S1750797AbWECUXJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 16:23:09 -0400
Subject: Re: [ck] 2.6.16-ck9
From: Juho Saarikko <juhos@mbnet.fi>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Con Kolivas <kernel@kolivas.org>, ck list <ck@vds.kolivas.org>,
       linux list <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0605031821140.13546@yvahk01.tjqt.qr>
References: <200605022338.20534.kernel@kolivas.org>
	 <1146603461.5213.32.camel@a88-112-69-25.elisa-laajakaista.fi>
	 <Pine.LNX.4.61.0605031821140.13546@yvahk01.tjqt.qr>
Content-Type: text/plain
Organization: 
Message-Id: <1146687698.3897.17.camel@a88-112-69-25.elisa-laajakaista.fi>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 03 May 2006 23:21:38 +0300
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-05-03 at 19:25, Jan Engelhardt wrote:
> >
> >I tried to run SetiAtHome at IDLEPRIO, but it competes equally with a
> >while(1); loop run at nice 19. I'm starting to wonder if there isn't
> >some kind of bug in the kernel which results in a program returning from
> >a system call with an in-kernel semaphore held. After all, according to
> >top, SetiAtHome consumes over 90% CPU, and the system consumes only
> >about 1%, so it can't be making system calls all the time either.
> 
> SAH does make very few system calls in relation to its computing, in fact. 
> [It's a guess, not a proven answer.] The boinc supervisor process is mostly 
> the syscall, filesystem and networking part.
> 
> >This pattern just keeps on repeating, endlessly. Occasionally it also
> >has
> >
> >kill(5432, SIG_0)                       = 0
> >
> >attached to it. 5432 is the parent process, the FAH502-Linux.exe.
> 
> You don't use boinc?

AARRGGHH. I meant FoldingAtHome.

That's what I get from not paying attention to what I'm typing ;(.

