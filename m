Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267920AbTAHUL4>; Wed, 8 Jan 2003 15:11:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267921AbTAHUL4>; Wed, 8 Jan 2003 15:11:56 -0500
Received: from packet.digeo.com ([12.110.80.53]:42422 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267920AbTAHULz>;
	Wed, 8 Jan 2003 15:11:55 -0500
Message-ID: <3E1C880A.87A93CFA@digeo.com>
Date: Wed, 08 Jan 2003 12:20:26 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.51 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Bob_Tracy(0000)" <rct@gherkin.frus.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: XFree86 vs. 2.5.54 - reboot
References: <20030108140525.DF0434EE7@gherkin.frus.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 08 Jan 2003 20:20:26.0305 (UTC) FILETIME=[6156EB10:01C2B753]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Bob_Tracy(0000)" wrote:
> 
> This probably applies to immediately prior kernels in the 2.5 series
> as well.  2.5.54 seemed like a good time to jump in and test the waters,
> so to speak...
> 
> AMD K6-III 450 running a 2.4.19 kernel with vesafb, XFree86 4.1.0, and
> a USB mouse works fine.  Same setup with a 2.5.54 kernel does a cold
> reboot when I type "startx".

I saw exactly the same.  In my case it appears to be due to miscompilation
of a particular sysenter patch which went into 2.5.53.  If you're using
gcc-2.91.66 (aka `kgcc') then try 2.95.x instead.
