Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261248AbVAMRJP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261248AbVAMRJP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 12:09:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261241AbVAMRHB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 12:07:01 -0500
Received: from mail.tmr.com ([216.238.38.203]:23820 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S261243AbVAMRFG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 12:05:06 -0500
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Bill Davidsen <davidsen@tmr.com>
Newsgroups: mail.linux-kernel
Subject: Re: propolice support for linux
Date: Thu, 13 Jan 2005 12:07:48 -0500
Organization: TMR Associates, Inc
Message-ID: <41E6AAE4.3010706@tmr.com>
References: <20050113140446.GA22381@infradead.org><20050113140446.GA22381@infradead.org> <20050113163733.GB14127@boetes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Trace: gatekeeper.tmr.com 1105635288 620 192.168.12.100 (13 Jan 2005 16:54:48 GMT)
X-Complaints-To: abuse@tmr.com
Cc: linux-kernel@vger.kernel.org
To: Han Boetes <han@mijncomputer.nl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
In-Reply-To: <20050113163733.GB14127@boetes.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Han Boetes wrote:
> Thanks for your comments! This wasn't my patch, just the closed
> thing to something working I could find. Here is my version.
> 
> Now all I wonder about is what the _NOVERS should become, since
> Arjen pointed it it `was dead,' since I don't really understand
> what he means with that.
> 
> Perhaps I should also add some additional comment about how little
> effect this extension resorts on kernel-level.
> 
> And I got two warnings about `int __guard = '\0\0\n\777';'
> 
> lib/propolice.c:15:15: warning: octal escape sequence out of range
> lib/propolice.c:15:15: warning: multi-character character constant

Unless you foresee a port of Linux to some 36 bit hardware (like 
MULTICS) with nine bit bytes, is there a reason not to us \377? I have 
used 36 (and 48) bit hardware, but I don't expect it to ever get a Linux 
port.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
