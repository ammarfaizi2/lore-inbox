Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262337AbTIEJe5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 05:34:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262309AbTIEJe5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 05:34:57 -0400
Received: from auth22.inet.co.th ([203.150.14.104]:23823 "EHLO
	auth22.inet.co.th") by vger.kernel.org with ESMTP id S262337AbTIEJe4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 05:34:56 -0400
From: Michael Frank <mhf@linuxmail.org>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: 2.6.0-test4-mm6
Date: Fri, 5 Sep 2003 17:32:33 +0800
User-Agent: KMail/1.5.2
References: <20030905015927.472aa760.akpm@osdl.org>
In-Reply-To: <20030905015927.472aa760.akpm@osdl.org>
Cc: Nigel Cunningham <ncunningham@clear.net.nz>,
       swsusp-devel-request@lists.sourceforge.net
X-OS: KDE 3 on GNU/Linux
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309051732.33529.mhf@linuxmail.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 05 September 2003 16:59, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test4/2
>.6.0-test4-mm6/
>
>
> This is only faintly tested.  It's mainly a syncup with people..
>
> . Initial support for kgdb-over-ethernet.  Mainly from Robert Walsh, based
>   on work by San Mehat.
>
>   It's pretty simple to use - read Documentation/i386/kgdb/kgdbeth.txt
>   carefully.
>
>   This uses the same ethernet driver hooks as netconsole, and is designed
>   to work alongside netconsole.
>
>   Currently it "supports" e100, eepro100, 3c59x, tlan and tulip.  Only e100
>   has been tested.

This is cute, Nigel can then debug swsusp in 2.6 via the internet while I sleep...

Regards
Michael

