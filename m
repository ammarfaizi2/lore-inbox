Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262719AbTJYRFq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Oct 2003 13:05:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262721AbTJYRFq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Oct 2003 13:05:46 -0400
Received: from main.gmane.org ([80.91.224.249]:17560 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262719AbTJYRFp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Oct 2003 13:05:45 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: [PM][ACPI] No ACPI interrupts after resume from S1
Date: Sat, 25 Oct 2003 19:05:39 +0200
Message-ID: <yw1xwuati6xo.fsf@kth.se>
References: <20031020141512.GA30157@hell.org.pl> <yw1x8yngj7xg.fsf@users.sourceforge.net>
 <20031020184750.GA26154@hell.org.pl> <yw1xekx7afrz.fsf@kth.se>
 <20031023082534.GD643@openzaurus.ucw.cz> <yw1xr813f1a3.fsf@kth.se>
 <3F98FDDF.1040905@cyberone.com.au> <yw1xbrs6652m.fsf@kth.se>
 <20031024222347.GB728@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:SjHHPZD1FvHZjab84+xSA3L2dGs=
Cc: acpi-devel@lists.sourceforge.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@ucw.cz> writes:

>> That took me one step further.  Now it loaded the image swap, but them
>> immediately rebooted.  I didn't have time to see if there were any
>> error messages.  I don't have a serial port, so I can't put a console
>> there.  This was with lots of modules loaded, so maybe unloading some
>> would help.  Are there any known broken drivers in this list:
>
> Try it completely without modules. I'm not sure how it should work
> with modules which means it probably does not work at all.

OK, so I tried it with just the a few modules loaded (those I couldn't
unload, for some reason), and it worked.  Now I guess I'll have to
track down which modules are being evil.

-- 
Måns Rullgård
mru@kth.se

