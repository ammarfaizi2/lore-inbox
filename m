Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751305AbVLIKBx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751305AbVLIKBx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 05:01:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751304AbVLIKBx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 05:01:53 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:48313 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751305AbVLIKBw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 05:01:52 -0500
Date: Fri, 9 Dec 2005 11:55:02 +0100
From: Ingo Molnar <mingo@elte.hu>
To: JANAK DESAI <janak@us.ibm.com>
Cc: chrisw@osdl.org, viro@ftp.linux.org.uk, dwmw2@infradead.org,
       jamie@shareable.org, serue@us.ibm.com, linuxram@us.ibm.com,
       jmorris@namei.org, sds@tycho.nsa.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH -mm 1/5] New system call, unshare
Message-ID: <20051209105502.GA20314@elte.hu>
References: <1134079791.5476.8.camel@hobbs.atlanta.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1134079791.5476.8.camel@hobbs.atlanta.ibm.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -1.6
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.6 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	1.2 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* JANAK DESAI <janak@us.ibm.com> wrote:

> [PATCH -mm 1/5] unshare system call: System call handler function 
> sys_unshare

>+       if (unshare_flags & ~(CLONE_NEWNS | CLONE_VM))
>+               goto errout;

just curious, did you consider all the other CLONE_* flags as well, to 
see whether it makes sense to add unshare support for them?

	Ingo
