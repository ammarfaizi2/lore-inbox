Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271368AbTGQJ6r (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 05:58:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271369AbTGQJ6r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 05:58:47 -0400
Received: from angband.namesys.com ([212.16.7.85]:42384 "EHLO
	angband.namesys.com") by vger.kernel.org with ESMTP id S271368AbTGQJ6p
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 05:58:45 -0400
Date: Thu, 17 Jul 2003 14:13:38 +0400
From: Oleg Drokin <green@namesys.com>
To: steven.newbury1@ntlworld.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: lots of oopses with recent kernels
Message-ID: <20030717101338.GA14381@namesys.com>
References: <20030716233555.KHTX28183.mta05-svc.ntlworld.com@[10.137.100.64]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030716233555.KHTX28183.mta05-svc.ntlworld.com@[10.137.100.64]>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Wed, Jul 16, 2003 at 11:35:55PM +0000, steven.newbury1@ntlworld.com wrote:

> I am using gcc version 3.3 20030623 (Red Hat Linux 3.3-12)
> so that may be to blame...
> ...but I have received the bellow oopses while copying files to a "Device-Mapper" striped device with
> 'tar cf - . | tar - -C /mnt/tmp'
> oops1: reiserfs format device (with BadRAM patch)
> oops2: ext2/3 format device (with BadRAM patch)
> oops3: reiserfs format device (with mem=320M BadRAM patch
>        removed.

Sigh, I see lots of times your kernel jumps at random addresses for no good reason.
(like in 2 out of your four oopses you attached).
Have you tried to compile without CONFIG_PREEMPT just to see if it will be any better?

Bye,
    Oleg
