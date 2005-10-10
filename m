Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751127AbVJJTkb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751127AbVJJTkb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 15:40:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751128AbVJJTkb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 15:40:31 -0400
Received: from ns1.suse.de ([195.135.220.2]:45748 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751127AbVJJTka (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 15:40:30 -0400
Date: Mon, 10 Oct 2005 21:40:29 +0200
From: Olaf Hering <olh@suse.de>
To: Simon Richter <Simon.Richter@hogyros.de>
Cc: linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
       linuxppc-dev@ozlabs.org
Subject: Re: error: implicit declaration of function 'cpu_die'
Message-ID: <20051010194029.GA13730@suse.de>
References: <20051010163349.GA1381@suse.de> <434A9B87.409@hogyros.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <434A9B87.409@hogyros.de>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Mon, Oct 10, Simon Richter wrote:

> Hi,
> 
> >arch/ppc/kernel/idle.c includes linux/smp.h, which includes asm-smp.h
> >only if CONFIG_SMP is defined.
> >As a result, cpu_die remains undefined for non-SMP builds.
> 
> I have used the attached patch for my tree[1], but this needs to be 
> cross-checked with the other architectures.

Looks good, should go into 2.6.14.



-- 
short story of a lazy sysadmin:
 alias appserv=wotan
