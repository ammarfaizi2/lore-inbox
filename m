Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271836AbRHUTkx>; Tue, 21 Aug 2001 15:40:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271839AbRHUTke>; Tue, 21 Aug 2001 15:40:34 -0400
Received: from hera.cwi.nl ([192.16.191.8]:19843 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S271836AbRHUTkc>;
	Tue, 21 Aug 2001 15:40:32 -0400
From: Andries.Brouwer@cwi.nl
Date: Tue, 21 Aug 2001 19:40:27 GMT
Message-Id: <200108211940.TAA184696@vlet.cwi.nl>
To: bcrl@redhat.com, satch@fluent-access.com
Subject: Re: FYI  PS/2 Mouse problems -- userland issue
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    From: Ben LaHaise <bcrl@redhat.com>

    On Tue, 21 Aug 2001, Stephen Satchell wrote:

    > This MAY be a kernel issue depending on where I locate the mouse
    > initialization code.  If it is in the kernel, then there will need
    > to be a patch to allow the mouse to be re-initialized into the mode
    > everyone expects.

[Funny - we just discussed this last week.]

    The kernel has nothing to do with reinitializing the mouse: X has to do
    that.

[Indeed. Or gpm.]

     I plan to submit a
    patch that replaces much of the existing pc keyboard/mouse code with state
    machine driven code that doesn't block interrupts out for long periods of
    time, as well as fixing a few of the lockup issues the current driver has.

Have you written the patch already?
There are interesting difficulties here.

Andries
