Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266613AbUI0KRm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266613AbUI0KRm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 06:17:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266615AbUI0KRm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 06:17:42 -0400
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:42432 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S266613AbUI0KRk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 06:17:40 -0400
Subject: Re: 2.6.9-rc2-mm1 swsusp bug report.
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Pavel Machek <pavel@suse.cz>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Kevin Fenzi <kevin@scrye.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040926224338.GS28810@elf.ucw.cz>
References: <20040924143714.GA826@openzaurus.ucw.cz>
	 <20040924210958.A3C5AA2073@voldemort.scrye.com>
	 <1096069216.3591.16.camel@desktop.cunninghams>
	 <20040925014546.200828E71E@voldemort.scrye.com>
	 <1096113235.5937.3.camel@desktop.cunninghams>
	 <415562FE.3080709@yahoo.com.au> <20040925154527.GA8212@elf.ucw.cz>
	 <1096149821.8359.1.camel@desktop.cunninghams>
	 <20040926100442.GG10435@elf.ucw.cz>
	 <1096235982.10015.1.camel@desktop.cunninghams>
	 <20040926224338.GS28810@elf.ucw.cz>
Content-Type: text/plain
Message-Id: <1096279492.4222.8.camel@laptop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Mon, 27 Sep 2004 20:12:05 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Mon, 2004-09-27 at 08:43, Pavel Machek wrote:
> You have system where you write image in two parts, and there are some
> pretty special rules what you may not touch when writing first part,
> IIRC. That is what scares me...

No special rules. It's just the LRU that shouldn't change, and it won't
because all other activity is stopped and I'm using direct bio submits
to do the reading and writing. I really should get around to finishing
that 'how-it-works' document so I can clear up all the FUD. :>

Nigel
-- 
Nigel Cunningham
Pastoral Worker
Christian Reformed Church of Tuggeranong
PO Box 1004, Tuggeranong, ACT 2901

Many today claim to be tolerant. True tolerance, however, can cope with others
being intolerant.

