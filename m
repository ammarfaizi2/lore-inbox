Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261318AbTH2PoP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 11:44:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261363AbTH2PoP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 11:44:15 -0400
Received: from mx2.it.wmich.edu ([141.218.1.94]:61579 "EHLO mx2.it.wmich.edu")
	by vger.kernel.org with ESMTP id S261318AbTH2Pm6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 11:42:58 -0400
Message-ID: <3F4F747E.7020601@wmich.edu>
Date: Fri, 29 Aug 2003 11:42:54 -0400
From: Ed Sweetman <ed.sweetman@wmich.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030722
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.6.0-test4-mm3
References: <20030828235649.61074690.akpm@osdl.org>
In-Reply-To: <20030828235649.61074690.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test4/2.6.0-test4-mm3/
> 
> 
> . Lots of small fixes.


It seems that since test3-mm2 ...possibly mm3, my kernels just hang 
after loading the input driver for the pc speaker.  Now directly after 
this on test3-mm1 serio loads.
  serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1

I'm guessing this is where the later kernels are hanging.
I checked and i dont see any serio/input patches since mm1 in test3 but 
every mm kernel i've tried since mm3 hangs at the same point where as 
mm1 does not.  All have the same config.  I'm using acpi as well.  This 
is a via amd board.  I dont wanna send a general email with all kinds of 
extra info (.config and such) unless someone is interested in the 
problem and needs it.

