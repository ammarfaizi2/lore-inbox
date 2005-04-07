Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262622AbVDGX1W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262622AbVDGX1W (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 19:27:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262620AbVDGXYy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 19:24:54 -0400
Received: from rproxy.gmail.com ([64.233.170.206]:51859 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262592AbVDGXV5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 19:21:57 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=VfXJEP/sYN6V5EJQan53A9TIdiDHHbVQfwjz7yyOhdhLXoiGxdIqhluqFMl39kJnkw7HFmZbD/hnljzgPeYUZU6c8SptIogTVnXS/jAO9zNigLn6yzk8/5yPBbqJpj5IYuFR8rIuZR87KZzaj/jFVA7k6NdbL1wRBLx3ppdsT/8=
Message-ID: <21d7e99705040716214fb21fae@mail.gmail.com>
Date: Fri, 8 Apr 2005 09:21:56 +1000
From: Dave Airlie <airlied@gmail.com>
Reply-To: Dave Airlie <airlied@gmail.com>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Kernel SCM saga..
Cc: Paul Mackerras <paulus@samba.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0504070747580.28951@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <Pine.LNX.4.58.0504060800280.2215@ppc970.osdl.org>
	 <16980.55403.190197.751840@cargo.ozlabs.ibm.com>
	 <Pine.LNX.4.58.0504070747580.28951@ppc970.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Are you happy with processing patches + descriptions, one per mail?
> 
> Yes. That's going to be my interim, I was just hoping that with 2.6.12-rc2
> out the door, and us in a "calming down" period, I could afford to not
> even do that for a while.
> 
> The real problem with the email thing is that it ends up piling up: what
> BK did in this respect was that anythign that piled up in a BK repository
> ended up still being there, and a single "bk pull" got it anyway - so if
> somebody got ignored because I was busy with something else, it didn't add
> any overhead. The queue didn't get "congested".
> 
> And that's a big thing. It comes from the "Linus pulls" model where people
> just told me that they were ready, instead of the "everybody pushes to
> Linus" model, where the destination gets congested at times.

Something I think we'll miss is bkbits.net in the long run, being able
to just push all patches for Linus to a tree and then forget about
that tree until Linus pulled from it was invaluable.. the fact that
this tree was online the whole time and you didn't queue up huge mails
for Linus's INBOX to be missed, meant a lot to me compared to pre-bk
workings..

Maybe now that kernel.org has been 'pimped out' we could set some sort
of system up where maintainers can drop a big load of patchsets or
even one big patch into some sort of public area and say this is my
diffs for Linus for his next pull and let Linus pull it at his
lesuire... some kinda rsync'y type thing comes to mind ...

so I can mail Linus and say hey Linus please grab
rsync://pimpedout.kernel.org/airlied/drm-linus and you grab everything
in there and I get notified perhaps or just a log like the bkbits
stats page, and Andrew can grab the patchsets the same as he does for
bk-drm now ... and I can have airlied/drm-2.6 where I can queue stuff
for -mm then just re-generate the patches for drm-linus later on..

Dave.
