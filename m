Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751189AbVIDHdq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751189AbVIDHdq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 03:33:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751211AbVIDHdq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 03:33:46 -0400
Received: from pD9F874C0.dip0.t-ipconnect.de ([217.248.116.192]:33408 "EHLO
	susi.maya.org") by vger.kernel.org with ESMTP id S1751189AbVIDHdp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 03:33:45 -0400
From: Andreas Hartmann <andihartmann@01019freenet.de>
X-Newsgroups: linux.kernel
Subject: Re: forbid to strace a program
Date: Sun, 04 Sep 2005 09:32:34 +0200
Organization: privat
Message-ID: <dfe7ui$14q$1@pD9F874C0.dip0.t-ipconnect.de>
References: <4IOGw-1DU-11@gated-at.bofh.it> <4IOGw-1DU-13@gated-at.bofh.it> <4IOGw-1DU-9@gated-at.bofh.it> <4IOQc-1Pk-23@gated-at.bofh.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Complaints-To: abuse@arcor.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.7.11) Gecko/20050806
X-Accept-Language: de, en-us, en
In-Reply-To: <4IOQc-1Pk-23@gated-at.bofh.it>
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chase Venters wrote:
>> Is there another way to do this? If the password is crypted, I need a
>> passphrase or something other to decrypt it again. Not really a solution
>> of the problem.
>>
>> Therefore, it would be best, to hide it by preventing stracing of the
>> application to all users and root.
>>
>> Ok, root could search for the password directly in the memory, but this
>> would be not as easy as a strace.
> 
> Obfuscation isn't really valid security. Making something 'harder' to break 
> isn't a solution unless you're making it hard enough that current technology 
> can't break it (eg... you always have the brute force option, but good crypto 
> intends to make such an option impossible without expending zillions of clock 
> cycles). 

You're right. If I would have a solution, which could do this, I would
prefer it.

> 
> Can I ask why you want to hide the database password from root?

It's easy: for security reasons. There could always be some bugs in some
software, which makes it possible for some other user, to gain root
privileges. Now, they could easily strace for information, they shouldn't
could do it. The password they could see, isn't just used for the DB, but
for some other applications, too. That's the disadvantage of general
(single sign on) passwords.


Kind regards,
Andreas Hartmann
