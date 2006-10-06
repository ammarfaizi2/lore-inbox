Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751406AbWJFKRp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751406AbWJFKRp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 06:17:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751410AbWJFKRp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 06:17:45 -0400
Received: from xexex.zapek.com ([213.41.240.83]:46004 "EHLO mail.zapek.com")
	by vger.kernel.org with ESMTP id S1751406AbWJFKRo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 06:17:44 -0400
From: David Gerber <dg-lkml@zapek.com>
To: Frank Sorenson <frank@tuxrocks.com>
Subject: Re: Keyboard Stuttering
Date: Fri, 6 Oct 2006 12:18:36 +0200
User-Agent: KMail/1.9.4
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610061218.36883.dg-lkml@zapek.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm experiencing some severe keyboard stuttering on my laptop.  The 
> problem is particularly bad in X, and I believe it also occurs at the 
> console, though I'm having a difficult time verifying that.  The problem 
> shows up as repeated characters (not regular key-repeat-related), and 
> sometimes dropped key presses.

(I'm not subscribed to the list, CC: to me if needed)

Same problem here. Intel Core 2 Duo with 2.6.19-rc1 x86_64 SMP. Happens on 
2.6.17 too. I use 'noapic' as a workaround but that disables one of the CPU 
core of course.

I cannot reproduce the problem within the console nor gdm. Only on the X 
desktop.

dmesg and dmidecode outputs are available at:
http://zapek.com/misc/9400_dmesg
http://zapek.com/misc/9400_dmidecode
This is a Dell Inspiron 9400.

-- 
Dave - http://zapek.com/
