Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262638AbTCSX2J>; Wed, 19 Mar 2003 18:28:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263054AbTCSX2J>; Wed, 19 Mar 2003 18:28:09 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:18952 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S262638AbTCSX2I>;
	Wed, 19 Mar 2003 18:28:08 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Andi Kleen <ak@muc.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.4.21-pre5 kksymoops for i386/ia64 
In-reply-to: Your message of "Wed, 19 Mar 2003 16:39:39 BST."
             <20030319153939.GA30899@averell> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 20 Mar 2003 10:38:55 +1100
Message-ID: <24872.1048117135@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Mar 2003 16:39:39 +0100, 
Andi Kleen <ak@muc.de> wrote:
>At least for me not working in cross compile setups is a critical bug.
>YMMV.

I can make modutils 2.4 (including kallsyms and depmod) work in cross
compile mode and still maintain backwards compatibility.  Conceptually
the change is simple, but it affects a lot of code and needs a lot of
testing.  I am not going to spend any time on adding cross compile
ability to modutils 2.4 until I see a defined need for it, people
saying "would be nice to have does not count".  If I cannot get
kallsyms into the kernel for native compiles, why should I waste my
time making kallsyms work for the even smaller group of people who do
cross compiles?

Bottom line - when, and only when, the kksymoops patch is in the 2.4
kernel, then I will spend the time to make modutils 2.4 work in cross
compile mode.  If you insist that kallsyms work in cross compile mode
before the patch goes in, then it is not going to happen and nobody
gets automatic oops decoding in 2.4.

