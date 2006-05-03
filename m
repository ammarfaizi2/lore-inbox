Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965153AbWECLYG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965153AbWECLYG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 07:24:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965152AbWECLYF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 07:24:05 -0400
Received: from [212.33.162.131] ([212.33.162.131]:48904 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S965000AbWECLYE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 07:24:04 -0400
From: Al Boldi <a1426z@gawab.com>
To: linux-kernel@vger.kernel.org
Subject: Re: LinuxQuestions.org - Community Bulletin
Date: Wed, 3 May 2006 14:21:48 +0300
User-Agent: KMail/1.5
Cc: linux-admin@vger.kernel.org, chuck gelm <chuck@gelm.net>, kloro@cox.net
References: <200605020407.a7286e265899@www.linuxquestions.org> <200605022341.42037.kloro@cox.net> <44584121.5080904@gelm.net>
In-Reply-To: <44584121.5080904@gelm.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="windows-1256"
Content-Transfer-Encoding: 7bit
Message-Id: <200605031421.48043.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

chuck gelm wrote:
> tom arnall wrote:
> >i am experiencing memory problems trying to run an application that
> > processes a file of about .5GB. So far my results are:
> >
> >(1) set ulimit as follows:
> >
> >	core file size        (blocks, -c) 0
> >	data seg size         (kbytes, -d) unlimited
> >	file size             (blocks, -f) unlimited
> >	max locked memory     (kbytes, -l) 256000
> >	max memory size       (kbytes, -m) 256000
> >	open files                    (-n) 1024
> >	pipe size          (512 bytes, -p) 8
> >	stack size            (kbytes, -s) 8192
> >	cpu time             (seconds, -t) unlimited
> >	max user processes            (-u) unlimited
> >	virtual memory        (kbytes, -v) 768000
> >
> >This gives me 'out of memory' errors.
> >
> >(2) set 'virtual memory' very high and the application hogs memory and
> > brings the rest of the system to almost a halt.
> >
> >Thanks in advance for any help you can give me,
> >
> >Tom Arnall
> >north spit, ca
>
> Hi, Tom:
>
>  I don't know anything about 'ulimit', but how much real memory do you
> have? I'd try adding another 2 Gigabytes of virtual memory.
> Also, try
>
>  nice -n 19 <application>
>
> so that it does not 'hog' the system so much.
>
> Run 'top' to watch how much memory your application uses.
>
> HTH, Chuck
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-admin" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

