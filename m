Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261318AbUK1WkM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261318AbUK1WkM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Nov 2004 17:40:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261156AbUK1WkL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Nov 2004 17:40:11 -0500
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:31670 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S261318AbUK1Wid (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Nov 2004 17:38:33 -0500
Subject: Re: Suspend 2 merge
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Christoph Hellwig <hch@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       hugang@soulinfo.com, Andrew Morton <akpm@zip.com.au>
In-Reply-To: <20041126123847.GD1028@elf.ucw.cz>
References: <1101292194.5805.180.camel@desktop.cunninghams>
	 <20041124132839.GA13145@infradead.org>
	 <1101329104.3425.40.camel@desktop.cunninghams>
	 <20041125192016.GA1302@elf.ucw.cz>
	 <1101422088.27250.93.camel@desktop.cunninghams>
	 <20041125232200.GG2711@elf.ucw.cz>
	 <1101426416.27250.147.camel@desktop.cunninghams>
	 <20041126003944.GR2711@elf.ucw.cz>
	 <1101455756.4343.106.camel@desktop.cunninghams>
	 <20041126123847.GD1028@elf.ucw.cz>
Content-Type: text/plain
Message-Id: <1101680972.4343.300.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Mon, 29 Nov 2004 09:35:03 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Fri, 2004-11-26 at 23:38, Pavel Machek wrote:
> My machine suspends in 7 seconds, and that's swsusp1. According to
> your numbers, suspend2 should suspend it in 1 second and LZE
> compressed should be .5 second.

Seven seconds? How much memory is in use when you start, and how much is
actually written to disk? If you're starting with 1GB of RAM in use,
I'll sit up and listen, but I suspect you're talking about something
closer to 20MB and init S :>

These discussions are getting really unreasonable. "I don't want that
feature, therefore it shouldn't be merged" isn't a valid argument.
Neither is "Well, I can suspend in seven seconds with hardly any memory
in use." If you just don't want suspend2 in the kernel, come out and say
it. But please, stop giving me lame arguments (more below deleted rather
than replied to).

Nigel
-- 
Nigel Cunningham
Pastoral Worker
Christian Reformed Church of Tuggeranong
PO Box 1004, Tuggeranong, ACT 2901

You see, at just the right time, when we were still powerless, Christ
died for the ungodly.		-- Romans 5:6

