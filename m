Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275822AbRJYSeQ>; Thu, 25 Oct 2001 14:34:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275861AbRJYSeG>; Thu, 25 Oct 2001 14:34:06 -0400
Received: from [213.96.124.18] ([213.96.124.18]:5358 "HELO dardhal")
	by vger.kernel.org with SMTP id <S275822AbRJYSdw>;
	Thu, 25 Oct 2001 14:33:52 -0400
Date: Thu, 25 Oct 2001 20:37:43 +0000
From: =?iso-8859-1?Q?Jos=E9_Luis_Domingo_L=F3pez?= 
	<jdomingo@internautas.org>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux Scheduler and Compilation
Message-ID: <20011025203743.B504@dardhal.mired.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <007501c15d68$94f12c60$8630fdd4@3232424>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <007501c15d68$94f12c60$8630fdd4@3232424>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, 25 October 2001, at 18:20:25 +0300,
Omer Sever wrote:

>      I have a project on Linux CPU Scheduler to make it Fair Share
> Scheduler.I will make some changes on some files such as sched.c vs...I will
> want to see the effect ot the change but recompilation of the kernel takes
> about half an hour on my machine.How can I minimize this time?Which part
> should I necessarily include in my config file for the kernel to minimize
> it?
> 
make is your friend: it will only recompile those files that changed from
the last compilation. If you modify some #includes in the code, I believe
you will have to also run "make dep" before, to get dependencies right.

Another approach would be to compile the kernel on another different
machine, should you have one more powerful that the one you expect to try
the kernel on.

-- 
José Luis Domingo López
Linux Registered User #189436     Debian Linux Woody (P166 64 MB RAM)
 
jdomingo EN internautas PUNTO org  => ¿ Spam ? Atente a las consecuencias
jdomingo AT internautas DOT   org  => Spam at your own risk

