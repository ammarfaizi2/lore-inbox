Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269146AbUIYAXu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269146AbUIYAXu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 20:23:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269147AbUIYAXu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 20:23:50 -0400
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:2219 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S269146AbUIYAXp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 20:23:45 -0400
Subject: Re: mlock(1)
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Bernd Eckenfels <ecki-news2004-05@lina.inka.de>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Chris Wright <chrisw@osdl.org>,
       Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Andrea Arcangeli <andrea@novell.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <E1CAzyM-0008DI-00@calista.eckenfels.6bone.ka-ip.net>
References: <E1CAzyM-0008DI-00@calista.eckenfels.6bone.ka-ip.net>
Content-Type: text/plain
Message-Id: <1096071873.3591.54.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Sat, 25 Sep 2004 10:25:44 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Sat, 2004-09-25 at 09:59, Bernd Eckenfels wrote:
> In article <20040924225900.GY3309@dualathlon.random> you wrote:
> > laptop (currently suspend dumps into the swap the cleartext key of any
> > cryptoloop device, making cryptoloop pretty much useless).  And the good
> > thing is that it won't even need to ask for a password.
> 
> Where would you store the key for the suspend image without asking?

You should really reply-to-all, not just to LKML. I've added the
original recipients back.

I have to admit that I'm not sure. I haven't begun to try to write the
support yet, or even look at how the other implementations do
encryption. (Pointers welcome!) I assume there should be some option to
save it in a file and get it via the initrd, and/or perhaps require the
user to type in a passphrase at the lilo prompt.

>From what I have seen, random keys are sometimes chosen. I guess the
point there is not so much to protect access to the image as to obscure
it? If so, the existing compression support in suspend2 probably helps
satisfy this requirement.

Regards,

Nigel

