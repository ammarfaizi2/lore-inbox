Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267585AbUG2QJ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267585AbUG2QJ5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 12:09:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267584AbUG2QCY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 12:02:24 -0400
Received: from rproxy.gmail.com ([64.233.170.193]:492 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S268083AbUG2Pym (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 11:54:42 -0400
Message-ID: <40c36779040729085427f0231a@mail.gmail.com>
Date: Thu, 29 Jul 2004 11:54:41 -0400
From: Brian Bruns <bbruns@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Interfaces losing inet6 addresses in ifconfig output after some uptime
In-Reply-To: <1091108537.14310.33.camel@nowhere.openssl.softmedia.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <1091108537.14310.33.camel@nowhere.openssl.softmedia.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Jul 2004 15:42:17 +0200, Marcello Barnaba wrote:
> This is somewhat strange, after an average of 25 days of uptime, either
> with kernel 2.6.6 or kernel 2.6.7 (didn't notice this with earlier
> kernels, but the problem may be there as well, sorry but I didn't care
> about this before, and the box is in production so it cannot be rebooted
> easily), ifconfig does not display the inet6 addresses of my interfaces
> anymore, but the addresses work as expected and are correctly in iproute
> output:
> 

I can confirm a somewhat similar problem on vanilla x86 2.6.7 kernel
running on an Athlon XP 2000+, EEPro 1000/TX.  Basically, ifconfig
shows all but the first inet6 address.  However, the address is still
recognized by the standard 'ip' program, and can be bound to by
applications as normal.

Uptime is 29 days, and I don't have the luxury of rebooting the box to
see if it clears the issue.

If you need more information on the system, please feel free to let me
know what you need exactly, and I'll get it to you.


-- 
Brian Bruns
The Summit Open Source Development Group
Open Solutions For A Closed World / Anti-Spam Resources
http://www.sosdg.org

The Abusive Hosts Blocking List
http://www.ahbl.org
