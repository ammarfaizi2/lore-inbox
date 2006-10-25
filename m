Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423384AbWJYM2R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423384AbWJYM2R (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 08:28:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423385AbWJYM2R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 08:28:17 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:58021 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1423384AbWJYM2Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 08:28:16 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:subject:date:mime-version:content-type:content-transfer-encoding:x-mailer:in-reply-to:x-mimeole:thread-index:message-id;
        b=qugvETI61Z7AeS8dhG0kvJOikFWwel/FK1S/jjSORgWofD6ULbO12rphSSGcQ/9WRHSgtaDaEKK1Fl6CdxwflxVNCrhQIUGVJ5/XFCMaA1K7jkd+mP5L86MIkFaWJlFo/YBDX/INLAB9dysNPNf9nNsDeo5SDuUCJTuRPHUzgWs=
From: "Michael" <michael.sallaway@gmail.com>
To: <ray-gmail@madrabbit.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: PROBLEM: Oops when doing disk heavy disk I/O
Date: Wed, 25 Oct 2006 22:28:02 +1000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
In-Reply-To: <2c0942db0610242112r738fe4ccg8702ef5175a7927c@mail.gmail.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2962
Thread-index: Acb369ILyGDeN2suRDG6/JMX6aQvWQARJidg
Message-ID: <453f585d.299e45f8.4666.371b@mx.google.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 

> -----Original Message-----
> From: Ray Lee [mailto:madrabbit@gmail.com] 
> Sent: Wednesday, 25 October 2006 2:13 PM
> 
> Try swapping out the RAM (or getting it down to 1Gig). Try a really
> old kernel, such as debian's 2.6.8 package.
> 
> Ray

Well, what do you know -- that seems to have fixed it! I took out one stick
of RAM (so it's down to 1 gig) and it seems to work fine, now, without any
boot parameters or anything. (mind you, murphy's law will dictate that it'll
crash about 30 seconds after I send this...)

I'm amazed at that -- but I'm not going to look a gift horse in the mouth,
this has been frustrating me for far too long. :-)

Although, having said that, I'm curious... It is working because there's
only 1 gig of RAM in there, or because it's only a single stick (ie. not
dual-channel)? It works fine with both sticks, individually, just not both
together... I wonder what the cause of it actually is...

Thanks heaps for the suggestion!

Cheers,
Michael



