Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263999AbTDWLhC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 07:37:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264000AbTDWLhC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 07:37:02 -0400
Received: from mail.set-software.de ([193.218.212.121]:58525 "EHLO
	gateway.local.net") by vger.kernel.org with ESMTP id S263999AbTDWLhB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 07:37:01 -0400
From: Michael Knigge <Michael.Knigge@set-software.de>
Date: Wed, 23 Apr 2003 11:47:39 GMT
Message-ID: <20030423.11473966@knigge.local.net>
Subject: Re: FileSystem Filter Driver
To: Abhishek Agrawal <abhishek@abhishek.agrawal.name>
CC: Nir Livni <nir_l3@netvision.net.il>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1051092516.1896.7.camel@abhilinux.cygnet.co.in>
References: <000501c30983$1ffb8950$ade1db3e@pinguin> <1051092516.1896.7.camel@abhilinux.cygnet.co.in>
X-Mailer: Mozilla/3.0 (compatible; StarOffice/5.1; Win32)
X-Priority: 3 (Normal)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> What's a FileSystem Filter Driver?

This is a driver that intercepts calls to the filesystem - for example 
for monitoring or to do additional access checks. Such a filter driver 
can then pass the call down to the filesystem or just cancel the call 
and (for example) return "access denied".


Under Windows a pretty well-known filter driver is FileMon at 
www.sysinternals.com. Thex also have a Linux version but (ahhh) 
without Source (the source for the Windows-Version is available). The 
Linux-Version can be found at 
http://www.sysinternals.com/linux/utilities/filemon.shtml

I guess what they are doing is similar to the way strace works - but 
I'm not sure. Hmmm, let us strace this thing ;-))))


Here are two Links that might help to implement such a thing under 
Linux (the most interesting is DaZuKo):

http://www.dazuko.org/
http://oss.sgi.com/projects/fam/



Bye
  Michael





