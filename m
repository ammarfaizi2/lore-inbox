Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266633AbUIAHP4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266633AbUIAHP4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 03:15:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266905AbUIAHPz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 03:15:55 -0400
Received: from rproxy.gmail.com ([64.233.170.198]:60661 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S266633AbUIAHPy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 03:15:54 -0400
Message-ID: <7f800d9f040901001551f92762@mail.gmail.com>
Date: Wed, 1 Sep 2004 00:15:50 -0700
From: Andre Eisenbach <int2str@gmail.com>
Reply-To: Andre Eisenbach <int2str@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.9-rc1-mm2
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040830235426.441f5b51.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20040830235426.441f5b51.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Aug 2004 23:54:26 -0700, Andrew Morton <akpm@osdl.org> wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc1/2.6.9-rc1-mm2/
>

Does not compile for me:

  CC      kernel/wait.o
kernel/wait.c:156: error: conflicting types for '__wait_on_bit'
include/linux/wait.h:143: error: previous declaration of
'__wait_on_bit' was here
kernel/wait.c:156: error: conflicting types for '__wait_on_bit'
include/linux/wait.h:143: error: previous declaration of
'__wait_on_bit' was here
kernel/wait.c:170: error: conflicting types for '__wait_on_bit_lock'
include/linux/wait.h:144: error: previous declaration of
'__wait_on_bit_lock' was here
kernel/wait.c:170: error: conflicting types for '__wait_on_bit_lock'
include/linux/wait.h:144: error: previous declaration of
'__wait_on_bit_lock' was here
make[1]: *** [kernel/wait.o] Error 1
make: *** [kernel] Error 2

Let me know if you need the .config or any other info.

Thanks for your continued hard work guys!

Cheers,
   Andre
