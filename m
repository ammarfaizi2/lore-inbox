Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264072AbTDWO7m (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 10:59:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264075AbTDWO7l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 10:59:41 -0400
Received: from [63.246.199.14] ([63.246.199.14]:10116 "EHLO ns.briggsmedia.com")
	by vger.kernel.org with ESMTP id S264072AbTDWO7h convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 10:59:37 -0400
Content-Type: text/plain; charset=US-ASCII
From: joe briggs <jbriggs@briggsmedia.com>
Organization: BMS
To: Abhishek Agrawal <abhishek@abhishek.agrawal.name>,
       Michael Knigge <Michael.Knigge@set-software.de>
Subject: Re: FileSystem Filter Driver
Date: Wed, 23 Apr 2003 12:11:22 -0400
User-Agent: KMail/1.4.3
Cc: Nir Livni <nir_l3@netvision.net.il>,
       linux-kernel <linux-kernel@vger.kernel.org>
References: <000501c30983$1ffb8950$ade1db3e@pinguin> <20030423.11473966@knigge.local.net> <1051099862.2099.6.camel@abhilinux.cygnet.co.in>
In-Reply-To: <1051099862.2099.6.camel@abhilinux.cygnet.co.in>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200304231211.22497.jbriggs@briggsmedia.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I once wrote a Windows 95/98 VXD that used the Microsoft mechanism - 
frequently called a 'hooker'.  In that case, you took a VXD template and made 
a system call that 'hooked' onto either a device or a filename.  In windows, 
each file I/O action generated an event.  You could listen for the event and 
then check to see if it was for your file or device, and if so, choose to 
selectively service (i.e, do the right thing), or pass it on to the normal 
driver, or a combination of both.  While at the time I thought "wow, what a 
cool way wreak havoc", it was the only way at the time to get around some 
other MS multimedia limitations.   If someone wants it, I'll be glad to dig 
it out.

On Wednesday 23 April 2003 08:11 am, Abhishek Agrawal wrote:
> On Wed, 2003-04-23 at 17:17, Michael Knigge wrote:
> > Under Windows a pretty well-known filter driver is FileMon at
> > www.sysinternals.com. Thex also have a Linux version but (ahhh)
> > without Source (the source for the Windows-Version is available). The
> > Linux-Version can be found at
> > http://www.sysinternals.com/linux/utilities/filemon.shtml
> >
> > I guess what they are doing is similar to the way strace works - but
> > I'm not sure. Hmmm, let us strace this thing ;-))))
>
> Filemon look like it will not work with kernel 2.5 up.
> From the link...
> "it replaces entries in the system call table with pointers to its own
> hook functions."
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Joe Briggs
Briggs Media Systems
105 Burnsen Ave.
Manchester NH 01304 USA
TEL/FAX 603-232-3115 MOBILE 603-493-2386
www.briggsmedia.com
