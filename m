Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262126AbVBAVjQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262126AbVBAVjQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 16:39:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262129AbVBAVjQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 16:39:16 -0500
Received: from wproxy.gmail.com ([64.233.184.199]:34373 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262126AbVBAVjF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 16:39:05 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=mDKmJhrHwT9GNtBK5fo84RL9odXMmybfhcVluh60oDb9fApvuvOy/gwmroAJMH4KepaPGvnu3+z/KxLWAc6vfvC8meRO7cieSe0DHeb2E0sYYbc1jCwidM/KEvd9OhIlW6Laa7g3pfea/WbcFxHeZLjQaRL5atudJfcKPLCXG5I=
Date: Tue, 1 Feb 2005 22:39:05 +0100
From: Diego Calleja <diegocg@gmail.com>
To: Peter Busser <busser@m-privacy.de>
Cc: arjan@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: Sabotaged PaXtest (was: Re: Patch 4/6  randomize the stack
 pointer)
Message-Id: <20050201223905.165a2a60.diegocg@gmail.com>
In-Reply-To: <200502011044.39259.busser@m-privacy.de>
References: <200501311015.20964.arjan@infradead.org>
	<200501311357.59630.busser@m-privacy.de>
	<1107189699.4221.124.camel@laptopd505.fenrus.org>
	<200502011044.39259.busser@m-privacy.de>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Tue, 1 Feb 2005 10:44:39 +0100 Peter Busser <busser@m-privacy.de> escribió:

> > which is clearly there to sabotage any segmentation based approach (eg
> > execshield and openwall etc); it cannot have any other possible use or
> > meaning.
> 
> Ah, so you are saying that I sabotaged PaXtest? Sorry to burst your bubble, 
> but the PaXtest tests are no real attacks. They are *simulated* attacks. The 
> do_mprotect() is there to *simulate* behaviour people found in GLIBC under 
> certain circumstances. In other words: This is how certain applications 
> behave when run on exec-shield. They complained that PaXtest showed 
> inaccurate results on exec-shield. Since the purpose of PaXtest is to show 
> accurate results, the lack thereof has been fixed.


And people complains that nobody uses pax....
