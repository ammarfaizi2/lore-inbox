Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263114AbTDRRE6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Apr 2003 13:04:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263158AbTDRRE6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Apr 2003 13:04:58 -0400
Received: from 217-125-129-224.uc.nombres.ttd.es ([217.125.129.224]:7661 "HELO
	cocodriloo.com") by vger.kernel.org with SMTP id S263114AbTDRRE5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Apr 2003 13:04:57 -0400
Date: Fri, 18 Apr 2003 19:28:59 +0200
From: Antonio Vargas <wind@cocodriloo.com>
To: Dave Mehler <dmehler26@woh.rr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: mkinitrd
Message-ID: <20030418172859.GB27055@wind.cocodriloo.com>
References: <000501c305cb$a7a8e6b0$0200a8c0@satellite>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000501c305cb$a7a8e6b0$0200a8c0@satellite>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 18, 2003 at 12:57:54PM -0400, Dave Mehler wrote:
> Hello,
>     Same deal as before, on my rh9 box i have mkinitrd version 3.4.42-1
>     Is this sufficient for running a 2.5 kernel? I heard there was some
> update to mkinitrd i might have to get, which might explain why the system
> is hanging after the initrd image, but have not been able to find it.
> Thanks.
> Dave.

Dave, I recall reading there are problems with building an ext2 initrd
because of the small size, and it seems that ext3 is fine at the moment.
Just try to tweak the initrd script to do a ext3 (add -j to the mke2fs).

Search for "Recent changes broke mkinitrd" on lkml for more details.

Greets, Antonio.

ps. I'm having problems running make menuconfig under gnome-terminal,
    and so filled a bugreport on bugzilla.redhat.com

    xterm works fine at least
