Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261843AbVDERYD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261843AbVDERYD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 13:24:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261851AbVDERYD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 13:24:03 -0400
Received: from 41-052.adsl.zetnet.co.uk ([194.247.41.52]:61710 "EHLO
	mail.esperi.org.uk") by vger.kernel.org with ESMTP id S261843AbVDEREl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 13:04:41 -0400
To: Soeren Sonnenburg <kernel@nn7.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: pktcddvd -> immediate crash
References: <1112640251.5410.30.camel@localhost>
From: Nix <nix@esperi.org.uk>
X-Emacs: because editing your files should be a traumatic experience.
Date: Tue, 05 Apr 2005 18:04:37 +0100
In-Reply-To: <1112640251.5410.30.camel@localhost> (Soeren Sonnenburg's
 message of "5 Apr 2005 11:06:14 +0100")
Message-ID: <87fyy5jgt6.fsf@amaterasu.srvr.nix>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5 Apr 2005, Soeren Sonnenburg whispered secretively:
> I wonder whether anyone could use the pktcddvd device without killing
> random jobs (due to sudden out of memory or better memory leaks in
> pktcddvd) and finally a complete freeze of the machine ?

I'm using it without difficulty.

> To reproduce just create an udf filesystem on some dvdrw, mount it rw
> and copy some large file to the mount point.

Well, I copied a 502Mb file to a CD/RW yesterday as part of my
regular backups. No problems.


I think we need more details (a .config would be nice, and preferably
a cat of /proc/slabinfo and a dmesg dump when the problem starts).

-- 
This is like system("/usr/funky/bin/perl -e 'exec sleep 1'");
   --- Peter da Silva
