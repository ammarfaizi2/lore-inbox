Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261236AbVGLG7U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261236AbVGLG7U (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 02:59:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261226AbVGLG7U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 02:59:20 -0400
Received: from b3162.static.pacific.net.au ([203.143.238.98]:40371 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S261238AbVGLG5t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 02:57:49 -0400
Subject: Re: [PATCH] [42/48] Suspend2 2.1.9.8 for 2.6.12: 618-core.patch
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Pavel Machek <pavel@ucw.cz>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050710182106.GI10904@elf.ucw.cz>
References: <11206164393426@foobar.com> <11206164443244@foobar.com>
	 <20050710182106.GI10904@elf.ucw.cz>
Content-Type: text/plain
Organization: Cycades
Message-Id: <1121151572.13869.42.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Tue, 12 Jul 2005 16:59:33 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Mon, 2005-07-11 at 04:21, Pavel Machek wrote:
> Hi!
> 
> Have you seen Christoph's recent fixes to refrigerator? You probably
> have same problems..... And he wanted to move refrigerator to sched/
> and make it more generic for page migration, too... what about using
> it, too? ;-).

Yeah. I'm using them already. I must say though that I don't think
sched.h is necessarily the best place for the refrigerator defines. Any
change to those functions and you have to recompile most of the kernel.
Is a refrigerator.h an idea?

Regards,

Nigel
-- 
Evolution.
Enumerate the requirements.
Consider the interdependencies.
Calculate the probabilities.
Be amazed that people believe it happened. 

