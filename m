Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314422AbSDRS5Y>; Thu, 18 Apr 2002 14:57:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314425AbSDRS5X>; Thu, 18 Apr 2002 14:57:23 -0400
Received: from zero.tech9.net ([209.61.188.187]:17929 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S314422AbSDRS5W>;
	Thu, 18 Apr 2002 14:57:22 -0400
Subject: Re: 2.4.19pre6+preempt problem...
From: Robert Love <rml@tech9.net>
To: Andrea Aime <aaime@libero.it>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200204181426.30823.aaime@libero.it>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 18 Apr 2002 14:57:24 -0400
Message-Id: <1019156244.5395.61.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-04-18 at 08:26, Andrea Aime wrote:
>  <3>X[15554] exited with preempt_count 1
> 
> To be sure I restarted the system, but I haven't notice any other problem so 
> far... (btw, I'm using NVidia latest drivers, compiled the kernel on a

Two things:

(a) ask nvidia.  binary modules => no help here

(b) it is not a preemption problem.  that preemption error message
    is because X died while holding a lock and exiting with a nonzero
    lock count prints a warning.

	Robert Love


