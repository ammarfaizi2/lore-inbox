Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932393AbWIVNCs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932393AbWIVNCs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 09:02:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932395AbWIVNCr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 09:02:47 -0400
Received: from nz-out-0102.google.com ([64.233.162.196]:17253 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932393AbWIVNCr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 09:02:47 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=IWJkjkfnBlJR0G5T0sP08DmuTrYwRn47nkHDFsErkVUbXZh8g2WwP6Vo8o+gPUYkzy4mHSUrO7bluYO6F9mEH42aR/5wCl2Fh4O94jh0sTBN8k7GIYNgCrUPJgzCicRGCT7ShSZi3dwXCSmzZRrJWUYAWhElovB4pH2ewp2IIIY=
Date: Fri, 22 Sep 2006 15:02:42 +0200
From: Alejandro Riveira =?UTF-8?B?RmVybsOhbmRleg==?= 
	<ariveira@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: "set_rtc_mmss: can't update from m to n" cluttering my logs
Message-ID: <20060922150242.4a46287b@localhost.localdomain>
In-Reply-To: <20060918192431.42ec5df5.akpm@osdl.org>
References: <20060918131303.2aed4dc4@localhost.localdomain>
	<20060918192431.42ec5df5.akpm@osdl.org>
X-Mailer: Sylpheed-Claws 2.1.1 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Mon, 18 Sep 2006 19:24:31 -0700
Andrew Morton <akpm@osdl.org> escribió:

> On Mon, 18 Sep 2006 13:13:03 +0200
> Alejandro Riveira Fernández  <ariveira@gmail.com> wrote:
> 
> > Hi, i'm using a 2.6.18-rc7 in an 3880+ X2 AM2 with an uli 1697 chipset
> > and i'm seeing this on the logs
> > 
> > Sep 18 12:49:34 localhost last message repeated 17 times
> > Sep 18 12:49:40 localhost last message repeated 3 times
> > Sep 18 12:49:44 localhost kernel: set_rtc_mmss: can't update from 110 to 49
> > Sep 18 12:49:57 localhost last message repeated 8 times
> > Sep 18 12:50:01 localhost kernel: set_rtc_mmss: can't update from 110 to 50
> > Sep 18 12:50:32 localhost last message repeated 17 times
> > Sep 18 12:50:41 localhost last message repeated 4 times
> > Sep 18 12:50:42 localhost kernel: set_rtc_mmss: can't update from 111 to 50
> 
> That code hasn't really changed in a long time.  Are you able to determine
> approximately which kernel version introduced this problem?


i can no know because i changed hardware with that kernel already
installed :(.

Btw the messages are gone with 2.6.18 final and i suspect that
everything comes down to a buggy bios

[You can ignore the rest of msg it is just a rant]

 Sometimes it messes up system date and time forcing fsck in hd's and
other headaches. i see a msg at boot time about bios not reserving
e820 memory and PCI: mmio disabled or something like that. i can not
tell for sure because oddly enough the msg does not end up in logs ??)


> 
> Thanks.  

Thanks to you for the time you invested in this useless msg and big
thanks for your work in Linux


---

> All is fine except that I can reliably "oops" it simply by trying to 
> read from /proc/apm (e.g. cat /proc/apm).
> oops output and ksymoops-2.3.4 output is attached.
> Is there anything else I can contribute?

The latitude and longtitude of the bios writers current position, and
a ballistic missile.

                --Alan Cox LKML-December 08,2000 

