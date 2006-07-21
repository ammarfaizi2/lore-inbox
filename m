Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030338AbWGUAVP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030338AbWGUAVP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jul 2006 20:21:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030419AbWGUAVP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jul 2006 20:21:15 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:33457 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1030338AbWGUAVO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jul 2006 20:21:14 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: "Dan Carpenter" <error27@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: shut down from CPU 0 [regression]
References: <a63d67fe0607171952o539a6a29te75ef332bcdbba22@mail.gmail.com>
Date: Thu, 20 Jul 2006 18:20:28 -0600
In-Reply-To: <a63d67fe0607171952o539a6a29te75ef332bcdbba22@mail.gmail.com>
	(Dan Carpenter's message of "Mon, 17 Jul 2006 19:52:16 -0700")
Message-ID: <m1hd1bkdv7.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Dan Carpenter" <error27@gmail.com> writes:

> http://kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=6660316cb7a1a2c59a73a52870490c0f782f45c1
>
> Even though you should be able to call ACPI power down from either
> CPU, I've seen some BIOSes that implement it wrong.  That's why the
> code was there.
> For example: https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=189052

I don't understand the complaint we should be forcing the action to
happen on the boot cpu from another place in the code.

Eric
