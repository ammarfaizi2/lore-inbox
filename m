Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265789AbSKAWBl>; Fri, 1 Nov 2002 17:01:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265790AbSKAWBl>; Fri, 1 Nov 2002 17:01:41 -0500
Received: from mailout03.sul.t-online.com ([194.25.134.81]:23447 "EHLO
	mailout03.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S265789AbSKAWBj>; Fri, 1 Nov 2002 17:01:39 -0500
Cc: Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org,
       davej@suse.de
References: <20021101085148.E105A2C06A@lists.samba.org>
	<1036175565.2260.20.camel@mentor>
From: Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>
To: Dax Kelson <dax@gurulabs.com>
Subject: Re: Filesystem Capabilities in 2.6?
Date: Fri, 01 Nov 2002 23:07:30 +0100
Message-ID: <877kfx54gt.fsf@goat.bogus.local>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) XEmacs/21.4 (Honest Recruiter,
 i386-debian-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dax Kelson <dax@gurulabs.com> writes:

> On Fri, 2002-11-01 at 01:49, Rusty Russell wrote:
>> I'm down to 8 undecided features: 6 removed and one I missed earlier.
>
> How about Olaf Dietsche's filesystem capabilities support? It has been
> posted a couple times to LK, yesterday even.

Judging from the silence, I guess my mails take the direct route from
inbox to /dev/null ;-). But never mind, since the patch is very small,
it's easy for people to add fs capabilities themselves, if they're
interested.

> We've had capabilities for ages (2.2?) but no filesystem support.

#define _LINUX_CAPABILITY_VERSION 0x19980330 says, it's at least four
and a half years old.

> OpenBSD is recently bragging about no longer having any SUID root
> binaries on the system.
>
> With FS capabilities we (Linux) can have the same situation.  Security
> is a hot topic, and anything the kernel can do make security
> better/easier seems worthy of consideration.

I think, it's not time for bragging yet, until fs capabilities get
quite a bit more testing.

Regards, Olaf.
