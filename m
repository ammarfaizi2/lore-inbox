Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317711AbSGVQjJ>; Mon, 22 Jul 2002 12:39:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317712AbSGVQjJ>; Mon, 22 Jul 2002 12:39:09 -0400
Received: from users-vst.linvision.com ([62.58.92.114]:11930 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S317711AbSGVQjJ>; Mon, 22 Jul 2002 12:39:09 -0400
Message-Id: <200207221642.SAA30690@cave.bitwizard.nl>
Subject: Re: close return value (was Re: [ANNOUNCE] Ext3 vs Reiserfs benchmarks)
In-Reply-To: <1026870340.2119.122.camel@irongate.swansea.linux.org.uk> from Alan
 Cox at "Jul 17, 2002 02:45:40 am"
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Mon, 22 Jul 2002 18:42:03 +0200 (MEST)
CC: Zack Weinberg <zack@codesourcery.com>, linux-kernel@vger.kernel.org
From: R.E.Wolff@BitWizard.nl (Rogier Wolff)
X-notice: Read http://www.bitwizard.nl/cou.html for the licence to my Emailaddr.
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> > And watch it come back with an error again, repeat ad infinitum?
> 
> The use of intelligence doesn't help. Come on I know you aren't a cobol
> programmer. Check for -EBADF ...

Huh? My mgetty/sendfax setup did something interesting lately.

I had not finished installing it, and I got a fax. It recieved it into
/tmp, tried moving it to /var/spool/fax/incoming, failed, and left the
tempfile in /tmp. It then mailed me about the recieved fax in /tmp. 

This is EXACTLY the intelligent behaviour that an application writer
can chose for when checking for error codes. Especially "don't unlink
your tempfiles" is easy if you get errors on conversion or copying....

			Roger. 


-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2137555 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* There are old pilots, and there are bold pilots. 
* There are also old, bald pilots. 
