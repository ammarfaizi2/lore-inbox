Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267295AbUHPAMs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267295AbUHPAMs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 20:12:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267301AbUHPAMs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 20:12:48 -0400
Received: from the-village.bc.nu ([81.2.110.252]:25314 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S267295AbUHPAMj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 20:12:39 -0400
Subject: Re: 2.6.8.1 Mis-detect CRDW as CDROM
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: John Wendel <jwendel10@comcast.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <411FF093.5090502@comcast.net>
References: <411FD919.9030702@comcast.net>
	 <1092603225.18415.2.camel@localhost.localdomain>
	 <411FF093.5090502@comcast.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1092611417.18580.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 16 Aug 2004 00:10:17 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2004-08-16 at 00:24, John Wendel wrote:
> >>K3B detects my Lite-on LTR-52327S CDRW as a CDROM when run with 2.6.8.1. 
> >>Booting back into 2.6.7 corrects the problem. I've attached the (totally 
> >>uninteresting parts of) dmesg.  Any clues  appreciated.
> What claim? I'm not claiming anything, just trying to report a problem. 
> I don't have the slightest idea what might be causing this problem, but 

Ah gotcha - I missed the "K3B" in the report so I was confused what was
deciding it wasn't a CDRW. Are you running it as root. 2.6.8 tightened
the security of some of the commands. That in part will need adjustment
but may mean K3B needs to run as root to burn CD's on 2.6.8

Alan

