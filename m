Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261434AbRERSfL>; Fri, 18 May 2001 14:35:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261430AbRERSfB>; Fri, 18 May 2001 14:35:01 -0400
Received: from jalon.able.es ([212.97.163.2]:50093 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S261434AbRERSe7>;
	Fri, 18 May 2001 14:34:59 -0400
Date: Fri, 18 May 2001 20:34:46 +0200
From: "J . A . Magallon" <jamagallon@able.es>
To: Bill Pringlemeir <bpringle@sympatico.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: APIC, AMD-K6/2 -mcpu=586...
Message-ID: <20010518203446.A1066@werewolf.able.es>
In-Reply-To: <m2u22ibww6.fsf@sympatico.ca> <m2d796twqe.fsf@sympatico.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <m2d796twqe.fsf@sympatico.ca>; from bpringle@sympatico.ca on Fri, May 18, 2001 at 19:04:09 +0200
X-Mailer: Balsa 1.1.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 05.18 Bill Pringlemeir wrote:
> 
> Why don't the build scripts run a dummy file to determine where the 
> floating point registers should be placed?
> 
> ...
> const int value = offsetof(struct task_struct, thread.i387.fxsave) & 15;
> ...
> 

That is not the problem. The problem is that the registers have to lay
in a defined way, transcribed to a C struct, and that pgcc lays badly that
struct.

-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Linux Mandrake release 8.1 (Cooker) for i586
Linux werewolf 2.4.4-ac11 #2 SMP Fri May 18 12:27:06 CEST 2001 i686

