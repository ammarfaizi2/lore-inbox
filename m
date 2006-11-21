Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966529AbWKUESO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966529AbWKUESO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 23:18:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966568AbWKUESO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 23:18:14 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:12689 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S966529AbWKUESN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 23:18:13 -0500
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1
From: Keith Owens <kaos@ocs.com.au>
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
cc: Jesper Juhl <jesper.juhl@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: How to go about debuging a system lockup? 
In-reply-to: Your message of "Thu, 16 Nov 2006 16:21:40 CDT."
             <20061116212140.GP8236@csclub.uwaterloo.ca> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 21 Nov 2006 15:17:49 +1100
Message-ID: <8823.1164082669@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lennart Sorensen (on Thu, 16 Nov 2006 16:21:40 -0500) wrote:
>On Thu, Nov 16, 2006 at 09:49:06PM +0100, Jesper Juhl wrote:
>> Well, I have a few ideas that are hopefully useul.
>> 
>> - If you have not done so already, then go in to the "Kernel Hacking"
>> section of the kernel configuration and enable some (all?) of the
>> debug options and see if that produces anything that will help you
>> track down the problem.
>
>I enabled the things that sounded useful.  I will try enabling the rest.
>
>> - You could enable 'magic sysrq' and see if you can manage to get a
>> backtrace with it when it hangs (see Documentation/sysrq.txt) (ohh and
>> raise the console log level so you get all messages, including debug
>> ones).
>
>Yeah I did that.  No response to sysrq (at least not on the serial
>console.  Maybe I should get a keyboard connector put on.)  Normally we
>run without VGA/keyboard/etc, and just serial console.  Of course the
>serial console requires working interrupts.  Not sure about the keyboard
>driver.
>
>> - You could also try kdb (http://oss.sgi.com/projects/kdb/) or kgdb
>> (http://kgdb.linsyssoft.com/). That might help you pinpoint the
>> failure.
>
>Can I run that remotely somehow?  I never really looked at kdb or kgdb
>before.

kgdb can only be run remotely.  kdb can be run on the local keyboard/console
or over a serial console.

