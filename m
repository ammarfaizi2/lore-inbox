Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262454AbTESMwQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 08:52:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262458AbTESMwQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 08:52:16 -0400
Received: from deviant.impure.org.uk ([195.82.120.238]:7910 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S262454AbTESMwP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 08:52:15 -0400
Date: Mon, 19 May 2003 14:08:20 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: S-n-e-a-k-e-r@gmx.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: int 0x15, ah=0x88 question
Message-ID: <20030519130820.GA30320@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	S-n-e-a-k-e-r@gmx.net, linux-kernel@vger.kernel.org
References: <9188.1053339727@www54.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9188.1053339727@www54.gmx.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 19, 2003 at 12:22:07PM +0200, S-n-e-a-k-e-r@gmx.net wrote:
 > 
 > 387         movb    $0x88, %ah
 > 388         int     $0x15
 > 389         movw    %ax, (2)
 > 
 > Why memory address 2 is used? Where else in the kernel is it used? We are in
 > real mode, so (2) should be the same as %ds:(2), or not?

This code is building the entries in the zero page for use later.

 > Sorry that I'm bugging the mailing list with that question but I didn't
 > found the answer anywhere. So a web page, a book or something else would be also
 > nice as an answer.

See Documentation/i386/zero-page.txt

		Dave

