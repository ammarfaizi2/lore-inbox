Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751279AbWHBGpi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751279AbWHBGpi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 02:45:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751276AbWHBGpi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 02:45:38 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:1518 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751279AbWHBGph (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 02:45:37 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, Horms <horms@verge.net.au>,
       Jan Kratochvil <lace@jankratochvil.net>,
       "H. Peter Anvin" <hpa@zytor.com>, Magnus Damm <magnus.damm@gmail.com>,
       Vivek Goyal <vgoyal@in.ibm.com>, Linda Wang <lwang@redhat.com>
Subject: Re: [PATCH 9/33] i386 boot: Add serial output support to the decompressor
References: <m1d5bk2046.fsf@ebiederm.dsl.xmission.com>
	<200608020507.50590.ak@suse.de>
	<m1slkfvinh.fsf@ebiederm.dsl.xmission.com>
	<200608020721.44139.ak@suse.de>
Date: Wed, 02 Aug 2006 00:44:00 -0600
In-Reply-To: <200608020721.44139.ak@suse.de> (Andi Kleen's message of "Wed, 2
	Aug 2006 07:21:44 +0200")
Message-ID: <m1u04vtz67.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> writes:

> On Wednesday 02 August 2006 06:57, Eric W. Biederman wrote:
>
> On x86-64 some trouble comes from it being 32bit code. 
> That is why I suggested making it 64bit first, which would
> avoid many of the problems.

:)
  
>> Whichever way I go scrutinizing that possibility carefully is
>> a lot of work.
>
> 64bit conversion would be some work, the rest isn't I think.

Except for the head.S work the 64bit conversion was practically a noop.

> Alternatively if you don't like it we can just drop these compressor patches.
> I don't think they were essential.

Agreed.  The printing portion wasn't essential.

At this point I think dropping the non-essential bits just to get the size
of the patchset down makes sense.

Eric
