Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263887AbTDVV5Y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 17:57:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263888AbTDVV5X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 17:57:23 -0400
Received: from watch.techsource.com ([209.208.48.130]:53721 "EHLO
	techsource.com") by vger.kernel.org with ESMTP id S263887AbTDVV5W
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 17:57:22 -0400
Message-ID: <3EA5C161.9060104@techsource.com>
Date: Tue, 22 Apr 2003 18:25:37 -0400
From: Timothy Miller <miller@techsource.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Valdis.Kletnieks@vt.edu
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Can one build 2.5.68 with allyesconfig?
References: <3EA5AABF.4090303@techsource.com> <200304222041.h3MKfILq027562@turing-police.cc.vt.edu>            <3EA5AE62.1040706@techsource.com> <200304222057.h3MKvbLq005110@turing-police.cc.vt.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Valdis.Kletnieks@vt.edu wrote:

>On Tue, 22 Apr 2003 17:04:34 EDT, Timothy Miller said:
>
>  
>
>
>'make -k' should suffice there.  I assume you're grovelling them out of
>the .o files?  Otherwise, just grepping the *.c should be OK.
>
Scanning .o files gets things which are not printk format strings. 
 Grepping .c files doesn't get macros.  The only choice is to produce .i 
files.

>
>Also, note that you probably want to *also* do an 'allmodconfig' just in
>case there's printk inside a #ifdef MODULE....
>  
>
What will get the greater coverage?  There seem to be some things that 
don't get 'y' or 'm' in .config when you do an allmodconfig.


