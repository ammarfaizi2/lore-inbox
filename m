Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292401AbSBBWKM>; Sat, 2 Feb 2002 17:10:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292402AbSBBWKA>; Sat, 2 Feb 2002 17:10:00 -0500
Received: from pc3-redb4-0-cust131.bre.cable.ntl.com ([213.106.223.131]:39929
	"HELO opel.itsolve.co.uk") by vger.kernel.org with SMTP
	id <S292401AbSBBWJ6>; Sat, 2 Feb 2002 17:09:58 -0500
Date: Sat, 2 Feb 2002 22:09:54 +0000
From: Mark Zealey <mark@zealos.org>
To: linux-kernel@vger.kernel.org
Subject: Re: Qn: kernel_thread()
Message-ID: <20020202220954.GB5032@itsolve.co.uk>
In-Reply-To: <MCOPFDJKMGLLEBAA@mailcity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MCOPFDJKMGLLEBAA@mailcity.com>
User-Agent: Mutt/1.3.25i
X-Operating-System: Linux sunbeam 2.4.17-wli2 
X-Homepage: http://zealos.org/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 02, 2002 at 10:46:20PM +0530, Alpha Beta wrote:

> In the code of 
> int kernel_thread(int (*fn)(void *), void * arg, unsigned long flags)
> in arch/i386/kernel/process.c
> 
> as can be seen in the code here, a system call is made by trigerring the 0x80 interrupt.
> this function kernel_thread() is used to launch the init process during booting by
> start_kernel()	//in init/main.c
> But at that time, the process 0 which calls kernel_thread is executing in Kernel mode, so why should some process in kernel mode make a system call??

Easy way to get the registers dumped into memory

-- 

Mark Zealey
mark@zealos.org
mark@itsolve.co.uk

UL++++>$ G!>(GCM/GCS/GS/GM) dpu? s:-@ a16! C++++>$ P++++>+++++$ L+++>+++++$
!E---? W+++>$ N- !o? !w--- O? !M? !V? !PS !PE--@ PGP+? r++ !t---?@ !X---?
!R- b+ !tv b+ DI+ D+? G+++ e>+++++ !h++* r!-- y--

(www.geekcode.com)
