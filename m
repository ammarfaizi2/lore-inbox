Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263032AbUCXHLS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 02:11:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263041AbUCXHLR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 02:11:17 -0500
Received: from mail.tpgi.com.au ([203.12.160.57]:41442 "EHLO mail1.tpgi.com.au")
	by vger.kernel.org with ESMTP id S263032AbUCXHLJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 02:11:09 -0500
Subject: Re: [Swsusp-devel] Re: swsusp problems [was Re: Your opinion on
	the merge?]
From: Nigel Cunningham <ncunningham@users.sourceforge.net>
Reply-To: ncunningham@users.sourceforge.net
To: Michael Frank <mhf@linuxmail.org>
Cc: Dmitry Torokhov <dtor_core@ameritech.net>, Pavel Machek <pavel@suse.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Swsusp mailing list <swsusp-devel@lists.sourceforge.net>
In-Reply-To: <opr5cry20s4evsfm@smtp.pacific.net.th>
References: <1079659165.15559.34.camel@calvin.wpcb.org.au>
	 <200403231743.01642.dtor_core@ameritech.net>
	 <20040323233228.GK364@elf.ucw.cz>
	 <200403232352.58066.dtor_core@ameritech.net>
	 <1080104698.3014.4.camel@calvin.wpcb.org.au>
	 <opr5cry20s4evsfm@smtp.pacific.net.th>
Content-Type: text/plain
Message-Id: <1080107188.2205.10.camel@laptop-linux.wpcb.org.au>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4-8mdk 
Date: Wed, 24 Mar 2004 17:46:28 +1200
Content-Transfer-Encoding: 7bit
X-TPG-Antivirus: Passed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Wed, 2004-03-24 at 18:22, Michael Frank wrote:
> Error messages should be handled on a seperate VT eliminating the issue.

While I definitely like the idea, I'm not sure that's feasible; as Pavel
pointed out, Suspend doesn't generate all the error messages that might
possibly appear. Maybe I'm just ignorant.. I'll take a look when I get
the change.

> How are bad blocks on a swap partition handled by the vm?

Good question :>

> Which reminds me of the "failed to read a chunk" message, the guys who reported
> it got all quiet after telling them to do more badblocks testing without diskcaching or
> using dd to write random data and read them back, so  likely was caused by
> media problems.

I'll reserve judgement there...

> Here we need more detailed error messages including the driver output  and the
> screen  should be switched to a text VT so messages are visible. Also as the
> error will cause resume to fail the system should be halted in this case.
> 
> IMO seperate message VT will eliminate all interference issues and further modularization
> by keeping the eye candy seperate.
> 
> Regards
> Michael
-- 
Nigel Cunningham
C/- Westminster Presbyterian Church Belconnen
61 Templeton Street, Cook, ACT 2614.
+61 (2) 6251 7727(wk); +61 (2) 6253 0250 (home)

Evolution (n): A hypothetical process whereby infinitely improbable events occur 
with alarming frequency, order arises from chaos, and no one is given credit.

