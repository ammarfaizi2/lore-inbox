Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261416AbUE3AdG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261416AbUE3AdG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 May 2004 20:33:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261418AbUE3AdG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 May 2004 20:33:06 -0400
Received: from opersys.com ([64.40.108.71]:4868 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S261416AbUE3AdD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 May 2004 20:33:03 -0400
Message-ID: <40B92D12.5040107@opersys.com>
Date: Sat, 29 May 2004 20:38:42 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: Dan Kegel <dank@kegel.com>
CC: John Bradford <john@grabjohn.com>, linux-kernel@vger.kernel.org
Subject: Re: Recommended compiler version
References: <40B8A161.5040306@kegel.com> <40B922D5.5090609@opersys.com>
In-Reply-To: <40B922D5.5090609@opersys.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Karim Yaghmour wrote:
...
> kernels as well, to see if they too would work. I noticed that
> some that actually failed as above (causing a fault very early
> at boot time), now didn't fail with 3.3.2, but printed nothing
> to the terminal and the system would eventually reboot -- as if
> console=ttyS0,9600 had no effect and the kernel panicked as
> expected because of the missing rootfs.

This just above is actually due pilot error. I had been trying so
many different kernels that I had forgotten to check whether
console on serial was enabled ... No wonder nothing was displayed.

To recap, I've also got the 2.4.25-ben1 and 2.6.6 working with
gcc 3.3.2. 2.4.25-ben1 still has the same problem as described
earlier with gcc 3.4.0, but 2.6.6 works fine with gcc 3.4.0.

I'm probably going to stick to 3.3.2, though, as I have no
intention of chasing gcc 3.4.0's breaking of some user-space
stuff.

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 1-866-677-4546

