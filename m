Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264404AbUGGF7J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264404AbUGGF7J (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 01:59:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264917AbUGGF7I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 01:59:08 -0400
Received: from mx1.redhat.com ([66.187.233.31]:42708 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264404AbUGGF7E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 01:59:04 -0400
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: Ray Lee <ray-lk@madrabbit.org>, tomstdenis@yahoo.com, eger@havoc.gtf.org,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 0xdeadbeef vs 0xdeadbeefL
References: <1089165901.4373.175.camel@orca.madrabbit.org>
	<20040707030227.GE12308@parcelfarce.linux.theplanet.co.uk>
From: Alexandre Oliva <aoliva@redhat.com>
Organization: Red Hat Global Engineering Services Compiler Team
Date: 07 Jul 2004 02:58:49 -0300
In-Reply-To: <20040707030227.GE12308@parcelfarce.linux.theplanet.co.uk>
Message-ID: <orisd0qrxi.fsf@livre.redhat.lsd.ic.unicamp.br>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul  7, 2004, viro@parcelfarce.linux.theplanet.co.uk wrote:

> On Tue, Jul 06, 2004 at 07:05:01PM -0700, Ray Lee wrote:
>> [1] "The great thing about standards is that there are so many
>> of them to choose from."  Wish I could remember who said
>> that.

> AST and in this case it actually doesn't apply - everything from K&R
> to C99 is in agreement here.

Are you sure?  I've seen K&R C compilers for 32-bit platforms in which
0xdeadbeef had type *signed* int, as opposed to unsigned int.  I
thought the preference for an unsigned type in this case was
introduced in ISO C90, but it might as well have been a bug in that
compiler.  Although I'm told other compilers display similar behavior.

-- 
Alexandre Oliva             http://www.ic.unicamp.br/~oliva/
Red Hat Compiler Engineer   aoliva@{redhat.com, gcc.gnu.org}
Free Software Evangelist  oliva@{lsd.ic.unicamp.br, gnu.org}
