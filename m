Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263214AbTCSWHB>; Wed, 19 Mar 2003 17:07:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263213AbTCSWHA>; Wed, 19 Mar 2003 17:07:00 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:48647 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S263214AbTCSWG6>;
	Wed, 19 Mar 2003 17:06:58 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Andi Kleen <ak@muc.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.4.21-pre5 kksymoops for i386/ia64 
In-reply-to: Your message of "Wed, 19 Mar 2003 16:39:39 BST."
             <20030319153939.GA30899@averell> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 20 Mar 2003 09:17:45 +1100
Message-ID: <23436.1048112265@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Mar 2003 16:39:39 +0100, 
Andi Kleen <ak@muc.de> wrote:
>On Tue, Mar 18, 2003 at 03:18:24AM +0100, Keith Owens wrote:
>> ps. The 2.5 kallsyms code is incompatible with modutils 2.4,
>> backporting the incomplete 2.5 kallsyms would only get debugging
>> symbols for the kernel, not for modules.  Changing modutils 2.4 is not
>> an option, I will not introduce an incompatible change in the middle of
>> a stable kernel series unless there is no choice (e.g. to fix a
>> critical bug).
>
>At least for me not working in cross compile setups is a critical bug.
>YMMV.

How the hell can it be a critical bug when 2.4 kernels do not currently
have _any_ kksymoops support?

