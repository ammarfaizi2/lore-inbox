Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261844AbVBXQqa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261844AbVBXQqa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 11:46:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262405AbVBXQqa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 11:46:30 -0500
Received: from keetweej.xs4all.nl ([213.84.46.114]:3525 "EHLO
	keetweej.vanheusden.com") by vger.kernel.org with ESMTP
	id S261844AbVBXQqX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 11:46:23 -0500
Date: Thu, 24 Feb 2005 17:46:22 +0100
To: linux-os <linux-os@analogic.com>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: accept() fails with EINTER
Message-ID: <20050224164620.GD5138@vanheusden.com>
References: <Pine.LNX.4.61.0502231009380.5342@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0502231009380.5342@chaos.analogic.com>
Organization: www.unixexpert.nl
Read-Receipt-To: <folkert@vanheusden.com>
X-Chameleon-Return-To: folkert@vanheusden.com
X-Xfmail-Return-To: folkert@vanheusden.com
Reply-By: Fri Feb 25 17:07:35 CET 2005
X-MSMail-Priority: High
User-Agent: Mutt/1.5.6+20040907i
From: folkert@vanheusden.com (Folkert van Heusden)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Trying to run an old server with a new kernel. A connection
> fails with "interrupted system call" as soon as a client
> attempts to connect. A trap in the code to continue
> works, but subsequent send() and recv() calls fail in
> the same way.

Weren't you supposed to just 'try again' when receiving EINTR (or
EAGAIN)?


Folkert van Heusden

Op zoek naar een IT of Finance baan? Mail me voor de mogelijkheden!
+------------------------------------------------------------------+
|UNIX admin? Then give MultiTail (http://vanheusden.com/multitail/)|
|a try, it brings monitoring logfiles to a different level! See    |
|http://vanheusden.com/multitail/features.html for a feature list. |
+------------------------------------------= www.unixsoftware.nl =-+
Phone: +31-6-41278122, PGP-key: 1F28D8AE
