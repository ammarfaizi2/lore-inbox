Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131086AbQLKA6N>; Sun, 10 Dec 2000 19:58:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131265AbQLKA6D>; Sun, 10 Dec 2000 19:58:03 -0500
Received: from zero.tech9.net ([209.61.188.187]:24324 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S131086AbQLKA5r>;
	Sun, 10 Dec 2000 19:57:47 -0500
Date: Sun, 10 Dec 2000 19:30:17 -0500 (EST)
From: "Robert M. Love" <rml@tech9.net>
To: Frank Davis <fdavis112@juno.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: test12-pre8 ohci1394.c compile error
In-Reply-To: <381711807.976492925796.JavaMail.root@web340-wra.mail.com>
Message-ID: <Pine.LNX.4.30.0012101926450.876-100000@phantasy.awol.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 10 Dec 2000, Frank Davis wrote:
> I suspect there are more. Is there a simple patch that will fix all
> affected drivers?

yah there are a lot. ive posted a couple of patches already.

the problem is because the task queue was changed (yes, this late in 2.4)
to a newer better design, and drivers have not been redone for the new
implementation. so, there is no simple patch, and we need to fix all
these.

patches like you did for i2o are what we need. basically its just changing
to the new macros/member names.

-- 
Robert M. Love
rml@ufl.edu
rml@tech9.net

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
