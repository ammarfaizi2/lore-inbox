Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263580AbUDBKUP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 05:20:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263584AbUDBKUP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 05:20:15 -0500
Received: from komp197.tera.com.pl ([81.21.195.197]:4546 "EHLO wrota.net")
	by vger.kernel.org with ESMTP id S263580AbUDBKUL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 05:20:11 -0500
Date: Fri, 2 Apr 2004 12:20:08 +0200
From: Daniel Fenert <daniel@fenert.net>
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Michelle Konzack <linux4michelle@freenet.de>
Subject: Re: Is there some bug in ext3 in 2.4.25?
Message-ID: <20040402102008.GA6336@fenert.net>
Mail-Followup-To: Daniel Fenert <daniel@fenert.net>,
	"Stephen C. Tweedie" <sct@redhat.com>,
	Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Michelle Konzack <linux4michelle@freenet.de>
References: <Pine.LNX.4.44.0403051048160.2678-100000@dmt.cyclades> <1078496713.14033.53.camel@sisko.scot.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1078496713.14033.53.camel@sisko.scot.redhat.com>
User-Agent: Mutt/1.4.2i
Organization: Wrota.NET
X-Operating-System: Linux 2.4.25
X-Wyslij-mi-SMSa: Lepiej nie...
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Old thread, but I've managed to test machine.

>> This sounds like memory corruption (which could be caused by a misbehaving
>> driver or by flaky hardware) because transaction->t_ilist is not used at
>> all by the kernel code. Did this box run stable with other kernels?
>
>Sounds like bad memory to me.  The only other report of this I've seen
>was at
>
>https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=115935
>
>and that machine didn't pass memtest86.

It passed memtest86, 6 or 7 hours, any further hints?

-- 
Daniel Fenert                 --==> daniel@fenert.net <==--
==-P o w e r e d--b y--S l a c k w a r e-=-ICQ #37739641-==
Najpro¶ciej pytaæ dlaczego, najtrudniej znale¼æ odpowied¼  --J. Szczawiñski
=======- http://daniel.fenert.net/ -=======< +48604628083 >
