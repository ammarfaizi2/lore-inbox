Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261597AbSJJOav>; Thu, 10 Oct 2002 10:30:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261598AbSJJOav>; Thu, 10 Oct 2002 10:30:51 -0400
Received: from mailman.xyplex.com ([140.179.176.116]:48022 "EHLO
	mailman.xyplex.com") by vger.kernel.org with ESMTP
	id <S261597AbSJJOau>; Thu, 10 Oct 2002 10:30:50 -0400
Message-ID: <19EE6EC66973A5408FBE4CB7772F6F0A046A3C@ltnmail.xyplex.com>
From: "Dow, Benjamin" <bdow@itouchcom.com>
To: "'Pavel Machek'" <pavel@ucw.cz>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: kernel memory leak?
Date: Thu, 10 Oct 2002 10:32:21 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<snip>

> Write C code to reproduce this on normal machine, and post it to
> bugtraq (its DoS, after all). Pretty aggresive but sure to get fixed
> *fast*.
> 
> The same without going bugtraq should suffice, through.
> 								
> 	Pavel
> 
> -- 
> I'm pavel@ucw.cz. "In my country we have almost anarchy and I 
> don't care."
> Panos Katsaloulis describing me w.r.t. patents at 
> discuss@linmodems.org
> 

That's the problem; I haven't been able to reproduce it yet on a "normal"
machine... I'm beginning to think it was a change to 2.4.9 that had some
unexpected side-effect in 2.4.19, though that doesn't really sit well with
me either.  I've been wracking my brain over this for days now, and
nothing's making any sense... I even tried applying different patches from
Andrea and Rik to change the VM behavior (since that was one of the biggest
changes between 2.4.9 and 19), but nothing's made a bit of difference.
Sorry, I'm just a bit frustrated.

Ben



 The information contained in this electronic mail is privileged and
confidential, intended only for the use of the individual or entity named
above. If the reader of this message is not the intended recipient, you are
hereby notified that any dissemination, distribution, copying or other use
of this communication is strictly prohibited. 
