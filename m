Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317990AbSGLG4n>; Fri, 12 Jul 2002 02:56:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317992AbSGLG4m>; Fri, 12 Jul 2002 02:56:42 -0400
Received: from khms.westfalen.de ([62.153.201.243]:56032 "EHLO
	khms.westfalen.de") by vger.kernel.org with ESMTP
	id <S317987AbSGLG4l>; Fri, 12 Jul 2002 02:56:41 -0400
Date: 12 Jul 2002 08:57:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: linux-kernel@vger.kernel.org
Message-ID: <8Skj1JtXw-B@khms.westfalen.de>
In-Reply-To: <20020711235822.8B2494849@lists.samba.org>
Subject: Re: Rusty's module talk at the Kernel Summit
X-Mailer: CrossPoint v3.12d.kh9 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
References: <E17Sbat-0002TF-00@starship> <20020711235822.8B2494849@lists.samba.org>
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

rusty@rustcorp.com.au (Rusty Russell)  wrote on 12.07.02 in <20020711235822.8B2494849@lists.samba.org>:

> I noted previously that you can do it if you do restrict the interface
> to "one module, one fs" approach, as you've suggested here.  Al
> corrected me saying that's not neccessary.  It's possible that he's
> come up with a new twist on the "freeze-the-kernel" approach or
> something.
>
> Al has scribbled in the margin that there's a clever solution, let's
> hope he doesn't die before revealing it. 8)

I suspect it's simply generalizing the concept of a registered interface.

Suppose you had *one* data structure that described *all* interfaces this  
module supports, and you call *one* (un)register function to do the job.

Then, you are essentially in the same situation as you are today when you  
support exactly one fs, no?

Of course, this registration abstraction must be powerful enough to do  
everything you can do today without it, but that's just a SMOP ...

MfG Kai
