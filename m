Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265270AbUBAPEf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Feb 2004 10:04:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265280AbUBAPEf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Feb 2004 10:04:35 -0500
Received: from relay.pair.com ([209.68.1.20]:38157 "HELO relay.pair.com")
	by vger.kernel.org with SMTP id S265270AbUBAPEd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Feb 2004 10:04:33 -0500
X-pair-Authenticated: 24.126.73.164
Message-ID: <401D14BB.9020901@kegel.com>
Date: Sun, 01 Feb 2004 07:01:15 -0800
From: Dan Kegel <dank@kegel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en, de-de
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, jinum@esntechnologies.co.in
Subject: re: FW: Linux device driver using c++!
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jinu wrote:
> Is there someway I can make use of a OS independent C++ code. This code has classes, 
> new, delete etc.. My plan was to build a static library using the C++ code and then 
> write a simple OS interface module which has the init, cleanup, read, write, ioctl 
> etc but calls C++ functions in the library.
> 
> Is this scenario possible?

Sure, just port it to C.

Seriously, you can do it in C++, but you'll hate yourself
afterwards, and nobody in the Linux community will support
you when you have problems.  C++ just does not mix well
with the Linux kernel.  This is not a shortcoming of the
Linux kernel; this is a fairly well-founded design decision,
discussed to death once every six months.

If you do decide to pursue it, do it in a way that does
not require any patches to the kernel source, and please
do NOT submit any patches related to this to the linux kernel mailing list.

- Dan



