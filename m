Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130007AbQKFVSR>; Mon, 6 Nov 2000 16:18:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130070AbQKFVSI>; Mon, 6 Nov 2000 16:18:08 -0500
Received: from [194.213.32.137] ([194.213.32.137]:2052 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S129984AbQKFVRv>;
	Mon, 6 Nov 2000 16:17:51 -0500
Message-ID: <20001106094553.C128@bug.ucw.cz>
Date: Mon, 6 Nov 2000 09:45:53 +0100
From: Pavel Machek <pavel@suse.cz>
To: "Amit S. Kale" <akale@veritas.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Translation Filesystem
In-Reply-To: <3A0109D6.4DFA2F62@veritas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <3A0109D6.4DFA2F62@veritas.com>; from Amit S. Kale on Thu, Nov 02, 2000 at 11:59:42AM +0530
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I have started a new virtual filesystem project, Translation Filesystem
> at
> http://trfs.sourceforge.net/  Description of the project is given below.
> 
> It's still at a concept stage. If someone has any ideas about any useful
> translators that fit in this framework please write to me.
> Any feedback is most welcome.


Well - I can certainly not do zero-copy block device access.

What are expected usages of your translation filesystem?
Hi-performance things like zero-copy block device access, or
low-performance things like transparently ungzipping? If it is the
second case, uservfs.sourceforge.net is perfectly applicable, if not,
you really need to modify kernel..
								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
