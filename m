Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267020AbUBGSLI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Feb 2004 13:11:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267010AbUBGSLI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Feb 2004 13:11:08 -0500
Received: from main.gmane.org ([80.91.224.249]:49792 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S267020AbUBGSLG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Feb 2004 13:11:06 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: Unknown symbol _exit when compiling VMware vmmon.o module
Date: Sat, 07 Feb 2004 19:11:03 +0100
Message-ID: <yw1xad3u7oaw.fsf@kth.se>
References: <1076175615.798.9.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: ti200710a080-1862.bb.online.no
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:8V2vKhPiNxay5CljeGCfL2bqTOY=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Felipe Alfaro Solana <felipe_alfaro@linuxmail.org> writes:

> Hi!
>
> After installing VMware Workstation 4.5.0-7174 and running
> vmware-config.pl, I get the following error when trying to insert
> vmmon.ko into the kernel:
>
> vmmon: Unknown symbol _exit

I've seen it too.  I just removed that call from the source and
rebuilt.  It's not supposed to ever get there anyway.  I still don't
understand what it was doing there in the first place.  Oddly, it
compiled with kernel 2.6.2, but not with some later updates.

-- 
Måns Rullgård
mru@kth.se

