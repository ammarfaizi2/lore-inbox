Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262588AbVAEVLc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262588AbVAEVLc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 16:11:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262591AbVAEVLc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 16:11:32 -0500
Received: from vvtp.tn.tudelft.nl ([130.161.252.29]:31122 "HELO
	vvtp.tudelft.nl") by vger.kernel.org with SMTP id S262588AbVAEVLa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 16:11:30 -0500
Date: Wed, 5 Jan 2005 22:11:09 +0100
From: Konrad Wojas <wojas@vvtp.tudelft.nl>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9 oops in poll()?
Message-ID: <20050105211109.GK31250@vvtp.tudelft.nl>
References: <20050103161556.GD31250@vvtp.tudelft.nl> <41DB1C92.7060501@osdl.org> <20050105040841.GI31250@vvtp.tudelft.nl> <41DC30C9.5050402@osdl.org> <20050105185733.GJ31250@vvtp.tudelft.nl> <41DC3BD6.3020303@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41DC3BD6.3020303@osdl.org>
X-Detect-Self: dd61600cfe762340a29ea869157aecee
User-Agent: Mutt/1.5.6+20040907i
X-AntiVirus: scanned on vvtp.tudelft.nl for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 05, 2005 at 11:11:18AM -0800, Randy.Dunlap wrote:
> Konrad Wojas wrote:
> >On Wed, Jan 05, 2005 at 10:24:09AM -0800, Randy.Dunlap wrote:
> >
> >>This probably needed to use /proc/kallsyms from the dying kernel,
> >>which you most likely don't have....
> >>
> >>I'm having trouble seeing what sock_poll() called (i.e., where EIP
> >>register points to).  In the /boot/System.map-2.6.9-1-686 file,
> >>is anything near address 0xc02b5513 listed?
> >>(or just send me that file privately)
> >
> >
> >Also doesn't look very helpfull to me..
> 
> True.  Have you tested this problem on 2.6.10 yet?

No, I don't even know how to reproduce this on 2.6.9.

> Back to 2.6.9:  do you normally run 2.6.9 with all of those same
> modules loaded?  If so, please send me the /proc/modules
> and /proc/kallsyms files.

I'm quite sure the same modules were loaded. I've sent the files by
private mail.

Regards,
-- 
Konrad Wojas                          .~.
~  wojas@vvtp.tudelft.nl             / V \
~                                   /(   )\
:wq       GnuPG key 0x588C85B1        ^ ^

