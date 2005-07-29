Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262754AbVG3AWX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262754AbVG3AWX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 20:22:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262761AbVG2TTA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 15:19:00 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:52105 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S262754AbVG2TQL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 15:16:11 -0400
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] reboot: remove device_suspend(PMSG_FREEZE) from
 kernel_kexec
References: <m18xzp4fam.fsf@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.58.0507291202130.3307@g5.osdl.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Fri, 29 Jul 2005 13:15:58 -0600
In-Reply-To: <Pine.LNX.4.58.0507291202130.3307@g5.osdl.org> (Linus
 Torvalds's message of "Fri, 29 Jul 2005 12:03:55 -0700 (PDT)")
Message-ID: <m1iryt2zkh.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> On Fri, 29 Jul 2005, Eric W. Biederman wrote:
>> 
>> If device_suspend(PMSG_FREEZE) is not ready to be called in
>> kernel_restart it is definitely ready to be called in the more the
>> more fickle kernel_kexec. 
>
> Ok, that was one of the more confused sentences I have ever seen, but I 
> fixed it up and applied it ;)
>
> I assume it should be "definitely <not> ready", and the duplication the
> duplication in "the more the more" is just because you're singing along 
> with some catchy tune and your fingers got away from you.

Something like that.  I have more problems writing a good
description of my code than actually writing the code.

Eric
