Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261642AbSJ1Wsn>; Mon, 28 Oct 2002 17:48:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261643AbSJ1Wsn>; Mon, 28 Oct 2002 17:48:43 -0500
Received: from mailout01.sul.t-online.com ([194.25.134.80]:26827 "EHLO
	mailout01.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S261642AbSJ1Wsm>; Mon, 28 Oct 2002 17:48:42 -0500
To: landley@trommello.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.44: what's .tmp_export-objs for?
References: <200210281054.16008.landley@trommello.org>
From: Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>
Date: Mon, 28 Oct 2002 23:54:50 +0100
In-Reply-To: <200210281054.16008.landley@trommello.org> (Rob Landley's
 message of "Mon, 28 Oct 2002 11:54:16 -0500")
Message-ID: <87y98inphh.fsf@goat.bogus.local>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) XEmacs/21.4 (Honest Recruiter,
 i386-debian-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Landley <landley@trommello.org> writes:

> I accidentally did a 2.5.44 kernel build as root rather than my normal user, 
> so I'm trying to see what clean steps I need to so (as root) to be able to 
> build the tree again.  A normal make clean failed (permission denied deleting 
> files), so I did an su and a make clean.  Exit back to normal user, make 
> clean, life is good, do a make dep, and it complains about the directory 
> .tmp_export-objs.
>
> 1) Why does the build process use a hidden directory?
>
> 2) Why isn't make clean removing something with "tmp" in the name?

"make help" lists a bunch of options. I guess, what you're searching
for is "make mrproper" or even "make distclean".

Regards, Olaf.
