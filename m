Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270515AbTGNDkh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 23:40:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270516AbTGNDkh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 23:40:37 -0400
Received: from auth22.inet.co.th ([203.150.14.104]:51972 "EHLO
	auth22.inet.co.th") by vger.kernel.org with ESMTP id S270515AbTGNDkf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 23:40:35 -0400
From: Michael Frank <mflt1@micrologica.com.hk>
To: Nigel Cunningham <ncunningham@clear.net.nz>, Pavel Machek <pavel@suse.cz>
Subject: Re: [Swsusp-devel] Re: Thoughts wanted on merging Software Suspend enhancements
Date: Mon, 14 Jul 2003 11:41:23 +0800
User-Agent: KMail/1.5.2
Cc: Jamie Lokier <jamie@shareable.org>,
       Dmitry Torokhov <dtor_core@ameritech.net>,
       swsusp-devel <swsusp-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1057963547.3207.22.camel@laptop-linux> <20030713210934.GK570@elf.ucw.cz> <1058147684.2400.9.camel@laptop-linux>
In-Reply-To: <1058147684.2400.9.camel@laptop-linux>
X-OS: KDE 3 on GNU/Linux
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307141141.25149.mflt1@micrologica.com.hk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 14 July 2003 09:54, Nigel Cunningham wrote:
> Okay.
>
> Having listened to the arguments, I'll make pressing Escape to cancel
> the suspend a feature which defaults to being disabled and can be
> enabled via a proc entry in 2.4. 

OK!

I won't add code to poll for ACPI (or
> APM) events :>

Sounds like a reasonable tradeoff

>
> Regards,
>
> Nigel
>
> On Mon, 2003-07-14 at 09:09, Pavel Machek wrote:
> > Hi!
> >
> > > Escape is more intuitively obvious though - I would expect the suspend
> > > button to only start a suspend. And the idea of escape cancelling
> > > anything is well in-grained in peoples' minds.
> >
> > You did not initiate suspend from keyboard => you should not
> > terminate it from keyboard.
> >


Overruled ;)
-- 
Powered by linux-2.5.75-mm1. Compiled with gcc-2.95-3 - mature and rock solid

My current linux related activities:
- 2.5 yenta_socket testing
- Test development and testing of swsusp for 2.4/2.5 and ACPI S3 of 2.5 kernel 
- Everyday usage of 2.5 kernel

More info on 2.5 kernel: http://www.codemonkey.org.uk/post-halloween-2.5.txt
More info on swsusp: http://sourceforge.net/projects/swsusp/

