Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752039AbWIXBVJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752039AbWIXBVJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Sep 2006 21:21:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752045AbWIXBVJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Sep 2006 21:21:09 -0400
Received: from wx-out-0506.google.com ([66.249.82.238]:34219 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1752039AbWIXBVH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Sep 2006 21:21:07 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=r/AdGYb5nnQBNS1JFP1grzFIOcGpcYSkT+FKpU1CX4tQkYpu7Qn+bRXZKScQKC/6OLnR+GSTSrI4qpjct8AlubJVRgvQTpBv5ZNLXQwMp6Xs6IHjWXKfj7JnnPyRdxQ4ALYexXKOOqXRMsWau19ev/TUOkKJTteoeMyVUzwI+AI=
Message-ID: <6bffcb0e0609231821q28124d7cr4bc4f10965bc043c@mail.gmail.com>
Date: Sun, 24 Sep 2006 03:21:06 +0200
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Dave Jones" <davej@redhat.com>,
       "Linux Kernel" <linux-kernel@vger.kernel.org>, ak@suse.de
Subject: Re: New Intel feature flags.
In-Reply-To: <20060924011532.GA5804@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060924011532.GA5804@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

On 24/09/06, Dave Jones <davej@redhat.com> wrote:
> Add supplemental SSE3 instructions flag, and Direct Cache Access flag.
> As described in "Intel Processor idenfication and the CPUID instruction
> AP485 Sept 2006"
>
> Signed-off-by: Dave Jones <davej@redhat.com>
>
> --- local-git/arch/i386/kernel/cpu/proc.c~      2006-09-23 20:46:35.000000000 -0400
> +++ local-git/arch/i386/kernel/cpu/proc.c       2006-09-23 20:48:02.000000000 -0400
> @@ -46,8 +46,8 @@ static int show_cpuinfo(struct seq_file
>
>                 /* Intel-defined (#2) */
>                 "pni", NULL, NULL, "monitor", "ds_cpl", "vmx", "smx", "est",
> -               "tm2", NULL, "cid", NULL, NULL, "cx16", "xtpr", NULL,
> -               NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
> +               "tm2", "ssse3", "cid", NULL, NULL, "cx16", "xtpr", NULL,

ssse3? Typo?

> +               NULL, NULL, "dca", NULL, NULL, NULL, NULL, NULL,
>                 NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
>
>                 /* VIA/Cyrix/Centaur-defined */
>
> --
> http://www.codemonkey.org.uk
> -

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/)
