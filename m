Return-Path: <linux-kernel-owner+w=401wt.eu-S932137AbXAHVeK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932137AbXAHVeK (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 16:34:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932126AbXAHVeK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 16:34:10 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:60461 "EHLO
	ebiederm.dsl.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932137AbXAHVeI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 16:34:08 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: "Lu, Yinghai" <yinghai.lu@amd.com>
Cc: "Linus Torvalds" <torvalds@osdl.org>,
       "Tobias Diedrich" <ranma+kernel@tdiedrich.de>,
       "Andrew Morton" <akpm@osdl.org>, "Adrian Bunk" <bunk@stusta.de>,
       "Andi Kleen" <ak@suse.de>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/4] x86_64 ioapic: Improve the heuristics for when check_timer fails.
References: <5986589C150B2F49A46483AC44C7BCA490736A@ssvlexmb2.amd.com>
Date: Mon, 08 Jan 2007 14:33:47 -0700
In-Reply-To: <5986589C150B2F49A46483AC44C7BCA490736A@ssvlexmb2.amd.com>
	(Yinghai Lu's message of "Mon, 8 Jan 2007 12:53:39 -0800")
Message-ID: <m1lkkdgq4k.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Lu, Yinghai" <yinghai.lu@amd.com> writes:

>>So that doesn't invalidate the generic test.  I'm going to go dig
>>out what little information I have and see if I can stair at the
>>register definition.
>
> Someone said we can that info about that reg in Kernel. And only
> firmware can use that.

We can do all kinds of things when firmware gets it wrong, and in this
case I just want a deeper understanding.  Once I understand that mess
I will decide what to do about it.

Eric
