Return-Path: <linux-kernel-owner+w=401wt.eu-S1030412AbWLTWjl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030412AbWLTWjl (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 17:39:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030413AbWLTWjl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 17:39:41 -0500
Received: from web32914.mail.mud.yahoo.com ([209.191.69.114]:46548 "HELO
	web32914.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1030412AbWLTWjk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 17:39:40 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=up9KV3SWby3zFqQ0RRFKWmr8NAoUgOvaL9RhVsfudOwu86MtlsXyz5xU2alJKMB4KeUsO6vC/YW8AXY3zL5Z7MybjvEgi7nc3lzBqTKtSzO4VDRfgcRpzBGJRaaNhrBP5kNrU/LLtmnkk7Ni8Px1s1HVPFY0NezW/cn/kyT8w3s=;
X-YMail-OSG: 1ygg2OsVM1mjOaj5lE6FD_rSgi8Nel19OjBey76gAI8bKlzh6_Fgar7b1CQUTBK_8hzY6gDJgXW5qGIbNmrK3z2m6ZkRaQq3IICCXDxS.yp0aDYfJqkqr5jc7MbIq87RCyEzCorCCguMidrzSfoobVXwyKNxmIHDxNmqsTOCZVWOpzrfKbsvEM.BBvyt
Date: Wed, 20 Dec 2006 14:39:39 -0800 (PST)
From: J <jhnlmn@yahoo.com>
Subject: Re: Possible race condition in usb-serial.c
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
In-Reply-To: <20061220204354.GA4039@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-ID: <718383.57861.qm@web32914.mail.mud.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for your reply.

> Which usb-serial driver are you having problems
> with?  What is the oops trace?  
> What version of the 2.4 kernel are you using?

I was told to fix an old embedded device, which my
company bought from somebody many years ago. 
It appears to have kernel 2.4.9 and a patched version
of visor.c.

However, I would't bother you with my antiquated
setup. I posted this message only when I started
to think that 2.6 may have race conditions as well.

And I don't have any oops. All I have is a monitor
with 30 lines worse of printk messages. This is
enough,
however, to discover races if printk are in the right
places.

> And why are you taking the linux-usb-devel list out
> of the cc:?  :)

This is because it is my first post on linux.kernel.
I spent time reading FAQs on http://www.tux.org/lkml/.
It wastes many pages explaining netiquette, but does
not really explain how to post other then 
"send to linux-kernel@vger.kernel.org". That's what I
did.

Thank you
John

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
