Return-Path: <linux-kernel-owner+w=401wt.eu-S932941AbWLNVhm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932941AbWLNVhm (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 16:37:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932940AbWLNVhm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 16:37:42 -0500
Received: from mail.tmr.com ([64.65.253.246]:53647 "EHLO gaimboi.tmr.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932941AbWLNVhl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 16:37:41 -0500
X-Greylist: delayed 1190 seconds by postgrey-1.27 at vger.kernel.org; Thu, 14 Dec 2006 16:37:41 EST
Message-ID: <4581C530.7010101@tmr.com>
Date: Thu, 14 Dec 2006 16:42:08 -0500
From: Bill Davidsen <davidsen@tmr.com>
Organization: TMR Associates Inc, Schenectady NY
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.8) Gecko/20061105 SeaMonkey/1.0.6
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Jean Delvare <khali@linux-fr.org>, Paul Mackerras <paulus@samba.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: sysfs file creation result nightmare (WAS radeonfb: Fix   sysfs_create_bin_file
 warnings)
References: <20061209165606.2f026a6c.khali@linux-fr.org>	<1165694351.1103.133.camel@localhost.localdomain>	<20061209123817.f0117ad6.akpm@osdl.org>	<20061209214453.GA69320@dspnet.fr.eu.org> <20061209135829.86038f32.akpm@osdl.org>
In-Reply-To: <20061209135829.86038f32.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

> Generally speaking, if sysfs file creation went wrong, it's due to a bug. 
> The result is that the driver isn't working as intended: tunables or
> instrumentation which it is designed to make available are not present.  We
> want to know about that bug asap so we can get it fixed.
> 
Failing to init the fb is certainly a good way to make sure the problem 
isn't overlooked, but perhaps a bit shy in the area of letting the user 
find out what the error was. Perhaps a warning would be better.


-- 
bill davidsen <davidsen@tmr.com>
   CTO TMR Associates, Inc
   Doing interesting things with small computers since 1979
