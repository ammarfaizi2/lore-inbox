Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290289AbSFTH1g>; Thu, 20 Jun 2002 03:27:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293203AbSFTH1f>; Thu, 20 Jun 2002 03:27:35 -0400
Received: from sj-msg-core-3.cisco.com ([171.70.157.152]:14530 "EHLO
	sj-msg-core-3.cisco.com") by vger.kernel.org with ESMTP
	id <S290289AbSFTH1f>; Thu, 20 Jun 2002 03:27:35 -0400
Message-ID: <3D1183AF.BCEE2BDF@cisco.com>
Date: Thu, 20 Jun 2002 00:26:39 -0700
From: Manik Raina <manik@cisco.com>
Organization: Cisco Systems
X-Mailer: Mozilla 4.76 [en] (X11; U; SunOS 5.8 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Dave Jones <davej@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [patch] scheduler bits from 2.5.23-dj1
References: <Pine.LNX.4.44.0206200123470.25434-100000@e2>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo,
	A small doubt, 
	Should'nt this function below return something ? 
	set_task_cpu() should return unsigned int but it
	seems to do nothing ....
	

Ingo Molnar wrote:
> +
> +static inline unsigned int set_task_cpu(struct task_struct *p, unsigned int cpu)
> +{
> +}
> +
> +#endif /* CONFIG_SMP */
> +
>  #endif /* __KERNEL__ */
>
