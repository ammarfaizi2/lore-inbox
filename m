Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292032AbSBAVCZ>; Fri, 1 Feb 2002 16:02:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292040AbSBAVCU>; Fri, 1 Feb 2002 16:02:20 -0500
Received: from pc3-redb4-0-cust131.bre.cable.ntl.com ([213.106.223.131]:21494
	"HELO opel.itsolve.co.uk") by vger.kernel.org with SMTP
	id <S292032AbSBAVBS>; Fri, 1 Feb 2002 16:01:18 -0500
Date: Fri, 1 Feb 2002 21:01:13 +0000
From: Mark Zealey <mark@zealos.org>
To: linux-kernel@vger.kernel.org
Subject: Re: Jiffies from userspace
Message-ID: <20020201210113.GA30684@itsolve.co.uk>
In-Reply-To: <20020201123321.A799@mars.starshine.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020201123321.A799@mars.starshine.org>
User-Agent: Mutt/1.3.25i
X-Operating-System: Linux sunbeam 2.4.17-wli2 
X-Homepage: http://zealos.org/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 01, 2002 at 12:33:21PM -0800, Jim wrote:

> 
>  Sorry if this question seems stupid, but would this be a 
>  reasonable way to get an estimate of the "current" value of the 
>  kernel's jiffies:
> 
>  	set -- `cat /proc/self/stat`; echo ${22}
> 
>  ... my reasoning:
> 
>  The cat will start a new process, field 22? of its "stat" node 
>  under proc should have the jiffies value at the time the process
>  was started; so the echo command execute "shortly" thereafter.

Maybe, another idea would be to look at /proc/interrupts, on the timer one
(IRQ0)...

-- 

Mark Zealey
mark@zealos.org
mark@itsolve.co.uk

UL++++>$ G!>(GCM/GCS/GS/GM) dpu? s:-@ a16! C++++>$ P++++>+++++$ L+++>+++++$
!E---? W+++>$ N- !o? !w--- O? !M? !V? !PS !PE--@ PGP+? r++ !t---?@ !X---?
!R- b+ !tv b+ DI+ D+? G+++ e>+++++ !h++* r!-- y--

(www.geekcode.com)
