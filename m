Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751278AbVICWeD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751278AbVICWeD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Sep 2005 18:34:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751280AbVICWeD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Sep 2005 18:34:03 -0400
Received: from relay02.pair.com ([209.68.5.16]:13325 "HELO relay02.pair.com")
	by vger.kernel.org with SMTP id S1751278AbVICWeC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Sep 2005 18:34:02 -0400
X-pair-Authenticated: 67.187.99.138
From: Chase Venters <chase.venters@clientec.com>
To: Andreas Hartmann <andihartmann@01019freenet.de>
Subject: Re: forbid to strace a program
Date: Sat, 3 Sep 2005 17:34:19 -0500
User-Agent: KMail/1.8.1
References: <4IExJ-4aE-21@gated-at.bofh.it> <4IMY1-7C1-19@gated-at.bofh.it> <dfd7pm$1c2$1@pD9F86CE8.dip0.t-ipconnect.de>
In-Reply-To: <dfd7pm$1c2$1@pD9F86CE8.dip0.t-ipconnect.de>
Cc: linux-kernel@vger.kernel.org
Organization: Clientec, Inc.
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509031734.19190.chase.venters@clientec.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Is there another way to do this? If the password is crypted, I need a
> passphrase or something other to decrypt it again. Not really a solution
> of the problem.
>
> Therefore, it would be best, to hide it by preventing stracing of the
> application to all users and root.
>
> Ok, root could search for the password directly in the memory, but this
> would be not as easy as a strace.

Obfuscation isn't really valid security. Making something 'harder' to break 
isn't a solution unless you're making it hard enough that current technology 
can't break it (eg... you always have the brute force option, but good crypto 
intends to make such an option impossible without expending zillions of clock 
cycles). 

Can I ask why you want to hide the database password from root?

Regards,
Chase Venters
