Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264809AbUEEVEQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264809AbUEEVEQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 May 2004 17:04:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264810AbUEEVEQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 May 2004 17:04:16 -0400
Received: from mail.tpgi.com.au ([203.12.160.59]:27621 "EHLO mail3.tpgi.com.au")
	by vger.kernel.org with ESMTP id S264809AbUEEVEN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 May 2004 17:04:13 -0400
Subject: Re: swsusp documentation updates
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Andrew Morton <akpm@zip.com.au>,
       Rusty trivial patch monkey Russell 
	<trivial@rustcorp.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040505101158.GC1361@elf.ucw.cz>
References: <20040505094719.GA4259@elf.ucw.cz>
	 <1083750907.17294.27.camel@laptop-linux.wpcb.org.au>
	 <20040505101158.GC1361@elf.ucw.cz>
Content-Type: text/plain
Message-Id: <1083791008.17292.32.camel@laptop-linux.wpcb.org.au>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5-2.norlug 
Date: Thu, 06 May 2004 07:03:28 +1000
Content-Transfer-Encoding: 7bit
X-TPG-Antivirus: Passed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Howdy.

On Wed, 2004-05-05 at 20:11, Pavel Machek wrote:
> Hi!
> 
> > > +There are two solutions to this:
> > > +
> > > +* require half of memory to be free during suspend. That way you can
> > > +read "new" data onto free spots, then cli and copy
> > 
> > Would you consider adding:
> > 
> > (Suspend2, which allows more than half of memory to be saved, is a
> > variant on this).
> 
> How would you like this added?

Well, I was thinking of simply adding the above in brackets on the same
or the next line.

> swsusp2 shares this fundamental limitation, but does not include user
> data and disk caches into "used memory" by saving them in
> advance. That means that limitation goes away in practice.
> 
> And perhaps you want to write "What is swsusp2?" question/answer?

I'm avoiding calling it swsusp2 because 'swsusp' is unpronouncable. It
also gets different interpretations: suspend2 isn't 'swap suspend'
because it's not inherently limited to saving to swap. 'software
suspend' is too long and doesn't seem to occur as quickly. Thus I'm
simply using suspend2.

Regards,

Nigel
-- 
Nigel & Michelle Cunningham
C/- Westminster Presbyterian Church Belconnen
61 Templeton Street, Cook, ACT 2614.
+61 (2) 6251 7727(wk); +61 (2) 6254 0216 (home)

Evolution (n): A hypothetical process whereby infinitely improbable events occur 
with alarming frequency, order arises from chaos, and no one is given credit.

