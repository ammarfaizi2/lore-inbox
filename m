Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282802AbRK0FIT>; Tue, 27 Nov 2001 00:08:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282804AbRK0FIJ>; Tue, 27 Nov 2001 00:08:09 -0500
Received: from zero.tech9.net ([209.61.188.187]:36361 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S282802AbRK0FIA>;
	Tue, 27 Nov 2001 00:08:00 -0500
Subject: Re: [PATCH] proc-based cpu affinity user interface
From: Robert Love <rml@tech9.net>
To: Anton Blanchard <anton@samba.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20011127153740.A13824@krispykreme>
In-Reply-To: <1006831902.842.0.camel@phantasy> 
	<20011127153740.A13824@krispykreme>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.1+cvs.2001.11.14.08.58 (Preview Release)
Date: 27 Nov 2001 00:08:28 -0500
Message-Id: <1006837709.971.6.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2001-11-26 at 23:37, Anton Blanchard wrote:
> > Attached is my procfs-based implementation of a user interface for
> > getting and setting a task's CPU affinity.  Patch is against 2.4.16. 
> 
> Have you seen Andrew Mortons cpus_allowed patch?

No, although Andrew mentioned he had worked on it to me.

Looking it over...its of course very similar.  One thing to note is his
patch doesn't incorporate the bits from Ingo's patch that I borrowed. 
I.e., use of cpu_online_map, the forcing of the reschedule, etc.  I
favor some of the differences in my variant.

I am glad to see he wrote a proc_write function, because I was worried I
was reimplementing something there, but I suppose not.

Either way, I'd like to see one of these in the kernel.

	Robert Love

