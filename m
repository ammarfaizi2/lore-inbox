Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262739AbTDIEto (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 00:49:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262740AbTDIEto (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 00:49:44 -0400
Received: from nycsmtp3out.rdc-nyc.rr.com ([24.29.99.224]:28908 "EHLO
	nycsmtp3out.rdc-nyc.rr.com") by vger.kernel.org with ESMTP
	id S262739AbTDIEtm (for <rfc822;linux-kernel@vger.kernel.org>); Wed, 9 Apr 2003 00:49:42 -0400
Message-ID: <3E93A958.80107@si.rr.com>
Date: Wed, 09 Apr 2003 01:02:16 -0400
From: Frank Davis <fdavis@si.rr.com>
Reply-To: fdavis@si.rr.com
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.0.2) Gecko/20030208 Netscape/7.02
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: kernel support for non-english user messages
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All,

I wish to suggest a possible 2.6 or 2.7 feature (too late for 2.4.x and 
2.5.x, I believe) that I believe would be helpful. Currently, printk 
messages are all in english, and I was wondering if printk could be 
modified to print out user messages that are in the default language of 
the machine. For example,

printk(KERN_WARN "This driver is messed up!\n", 'en'); //Prints the 
english text .

printk(KERN_WARN "This driver is messed up!\n", 'wel'); //Prints the 
welsh translation of the english text.

printk(KERN_WARN "This driver is messed up!\n", getdefaultlanguage());

I'm looking for a possible uniform design to make this happen, short of 
adding a complete machine translation module to the kernel. :) Userland 
internationalization support is already provided(I haven't personally 
used other languages besides English, but I've seen the options), but a 
kernel module or printk addition that handles localized kernel messages 
seems reasonable.

Thoughts, comments?

Regards,
Frank

