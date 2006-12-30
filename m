Return-Path: <linux-kernel-owner+w=401wt.eu-S965231AbWL3ScM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965231AbWL3ScM (ORCPT <rfc822;w@1wt.eu>);
	Sat, 30 Dec 2006 13:32:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965233AbWL3ScM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Dec 2006 13:32:12 -0500
Received: from mcr-smtp-001.bulldogdsl.com ([212.158.248.7]:1263 "EHLO
	mcr-smtp-001.bulldogdsl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S965231AbWL3ScL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Dec 2006 13:32:11 -0500
X-Spam-Abuse: Please report all spam/abuse matters to abuse@bulldogdsl.com
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: Oops in 2.6.19.1
Date: Sat, 30 Dec 2006 18:32:37 +0000
User-Agent: KMail/1.9.5
Cc: Chuck Ebbert <76306.1226@compuserve.com>, linux-kernel@vger.kernel.org
References: <200612201550_MC3-1-D5C7-74C6@compuserve.com> <4596AAA5.9020506@superbug.co.uk>
In-Reply-To: <4596AAA5.9020506@superbug.co.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612301832.37373.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 30 December 2006 18:06, James Courtier-Dutton wrote:
> > I'd guess you have some kind of hardware problem.  It could also be
> > a kernel problem where the saved address was corrupted during an
> > interrupt, but that's not likely.
>
> This looks rather strange.
[snip]

> 2) Kernel modules compiled with different gcc than rest of kernel.

Previously there was only one GCC version (4.1.1 totally replaced 3.4.3, and 
is the system wide GCC), now I have installed 3.4.6 into /opt/gcc-3.4.6 and 
it is only PATH'ed explicitly by me when I wish to compile a kernel using it:

export PATH=/opt/gcc-3.4.6/bin:$PATH
cp /boot/config-2.6.19-test .config
make oldconfig
make

> 3) kernel headers do not match the kernel being used.

The tree is a pristine 2.6.19.

> One way to start tracking this down would be to run it with the fewest
> amount of kernel modules loaded as one can, but still reproduce the
> problem.

Crippling the machine, though. Impractical for something that isn't 
immediately reproducible.

-- 
Cheers,
Alistair.

Final year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
