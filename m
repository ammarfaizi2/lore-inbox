Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313163AbSDDM45>; Thu, 4 Apr 2002 07:56:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313162AbSDDM4r>; Thu, 4 Apr 2002 07:56:47 -0500
Received: from ns1.alcove-solutions.com ([212.155.209.139]:36761 "EHLO
	smtp-out.fr.alcove.com") by vger.kernel.org with ESMTP
	id <S312311AbSDDM42>; Thu, 4 Apr 2002 07:56:28 -0500
Date: Thu, 4 Apr 2002 14:56:14 +0200
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Patch: linux-2.5.8-pre1/kernel/exit.c change caused BUG() at boot time
Message-ID: <20020404125614.GE9820@come.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
Mail-Followup-To: Stelian Pop <stelian.pop@fr.alcove.com>,
	"Adam J. Richter" <adam@yggdrasil.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20020404035910.A281@baldur.yggdrasil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 04, 2002 at 03:59:10AM -0800, Adam J. Richter wrote:

> 	When I attempted to boot linux-2.5.8-pre1, I got a kernel
> BUG() for exit.c line 519.  The was a small change to to kernel/exit.c
> in 2.5.8-pre1 which deleted a kernel_lock() call.  Restoring that line
> resulted in a kernel that booted fine.  I am sending this email from
> the machine running that kernel (so I guess a matching release of
> the kernel lock is already in the code).

It should be added that the bug is hit only if CONFIG_PREEMPT is on.

Stelian.
-- 
Stelian Pop <stelian.pop@fr.alcove.com>
Alcove - http://www.alcove.com
