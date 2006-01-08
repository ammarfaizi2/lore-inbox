Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161086AbWAHTdy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161086AbWAHTdy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 14:33:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161106AbWAHTdy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 14:33:54 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:4034 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1161086AbWAHTdw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 14:33:52 -0500
From: Junio C Hamano <junkio@cox.net>
To: Martin Langhoff <martin.langhoff@gmail.com>
Cc: "Brown, Len" <len.brown@intel.com>,
       "David S. Miller" <davem@davemloft.net>, torvalds@osdl.org,
       linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, akpm@osdl.org,
       git@vger.kernel.org
Subject: Re: git pull on Linux/ACPI release tree
References: <F7DC2337C7631D4386A2DF6E8FB22B3005A13505@hdsmsx401.amr.corp.intel.com>
	<46a038f90601081119r39014fbi995cc8b6e95774da@mail.gmail.com>
Date: Sun, 08 Jan 2006 11:33:49 -0800
In-Reply-To: <46a038f90601081119r39014fbi995cc8b6e95774da@mail.gmail.com>
	(Martin Langhoff's message of "Mon, 9 Jan 2006 08:19:50 +1300")
Message-ID: <7vace61plu.fsf@assigned-by-dhcp.cox.net>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Langhoff <martin.langhoff@gmail.com> writes:

> On 1/9/06, Brown, Len <len.brown@intel.com> wrote:
>> Perhaps the tools should try to support what "a lot of people"
>> expect, rather than making "a lot of people" do extra work
>> because of the tools?
>
> I think it does. All the tricky stuff that David and Junio have been
> discussing is actually done very transparently by
>
>     git-rebase <upstream>
>
> Now, git-rebase uses git-format-patch <options> | git-am <options> so
> it sometimes has problems merging.

Careful.  I do not think rebase works across merges at all.

