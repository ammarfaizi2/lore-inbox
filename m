Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265310AbUGGSrg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265310AbUGGSrg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 14:47:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265305AbUGGSrg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 14:47:36 -0400
Received: from web41113.mail.yahoo.com ([66.218.93.29]:64343 "HELO
	web41113.mail.yahoo.com") by vger.kernel.org with SMTP
	id S265301AbUGGSrZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 14:47:25 -0400
Message-ID: <20040707184721.54062.qmail@web41113.mail.yahoo.com>
Date: Wed, 7 Jul 2004 11:47:21 -0700 (PDT)
From: tom st denis <tomstdenis@yahoo.com>
Subject: Re: 0xdeadbeef vs 0xdeadbeefL
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040707142210.GG12308@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- viro@parcelfarce.linux.theplanet.co.uk wrote:
> Exercise:
> 	1) what type does an integer constant 0xdeadbeef have on a platform
> with INT_MAX equal to 0x7fffffff and UINT_MAX equal to 0xffffffff?
> 	2) when does the situation differ for integer constant 3735928559?
> 
> Oh, and do read the part of C standard in question.  Hint: extra
> restrictions
> are placed on decimal constants, not on the octals and hexadecimals.

That may be true but what does it hurt to imply the dimensions ahead of
time?  You meant an unsigned long constant so add the UL suffix.

Tom


		
__________________________________
Do you Yahoo!?
Yahoo! Mail Address AutoComplete - You start. We finish.
http://promotions.yahoo.com/new_mail 
