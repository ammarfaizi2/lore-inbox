Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932196AbVL0Ct0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932196AbVL0Ct0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Dec 2005 21:49:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932197AbVL0Ct0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Dec 2005 21:49:26 -0500
Received: from xproxy.gmail.com ([66.249.82.207]:26557 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932196AbVL0CtZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Dec 2005 21:49:25 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=aohBKXQy0wISwuPOjP4EVIfKfymaJgvhcEvqGfmkOa/DDOymsNDdAh16psXjzGkSphuNHz273aUpenR6ZjvGi6t3RWPRNwTmPFzYE8NwZ6i76upagFGR0oyZZ9EUsTLn9kyXnodUI1F5sToIwy/AXEm5brWgSdbi4muLxXV399E=
Message-ID: <5bdc1c8b0512261849i3c935887gedf116bf9faa29e1@mail.gmail.com>
Date: Mon, 26 Dec 2005 18:49:24 -0800
From: Mark Knecht <markknecht@gmail.com>
To: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Ho ho ho.. Linux 2.6.15-rc7
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1135620892.8293.60.camel@mindpipe>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <Pine.LNX.4.64.0512241930370.14098@g5.osdl.org>
	 <5bdc1c8b0512261002n6167a78ewfc45a6d3a5078ac0@mail.gmail.com>
	 <1135620892.8293.60.camel@mindpipe>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/26/05, Lee Revell <rlrevell@joe-job.com> wrote:
> On Mon, 2005-12-26 at 10:02 -0800, Mark Knecht wrote:
> > Hi Linus,
> >    I've visiting at my parents house and gave 2.6.15-rc7 a try on my
> > dad's machine. This machine is his normal desktop box which I
> > administer remotely, as well as a MythTV server. The new kernel built
> > and booted fine. I then built the NVidia stuff. However when I tried
> > to build the ivtv driver from portage it failed:
>
> There's nothing the kernel developers can do about regressions in out of
> tree modules - there is no stable kernel module API so the authors of
> that module will have to fix it.
>
> Any idea why the IVTV module has not been submitted for mainline?
>
> Lee

Lee, et all,
   Yes, I understood ivtv wasn't part of the kernel, and I did
consider trying something newer, but that meant testing that this new
ivtv didn't cause other problems which I didn't have time for as I'm
leaving tomorrow morning for home. Testing ivtv within MythTV is a
long involved process (literally hours and hours really) and I didn't
want to leave my folks without their beloved TV recording system if
something went wrong. I'll test the new kernel on my machines at home,
including with ivtv, and then I'll update them when I know it works
for me.

   None the less, and maybe as a non-developer I'm seeing this wrong,
but when a new kernel causes some drive to say a symbol isn't
available, as a user type I have no way of knowing if the symbol was
dropped on purpose or something got left out.

   I'm glad it's considered a non-issue.

Best regards and Happy upcoming New Years,
Mark
