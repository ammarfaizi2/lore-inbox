Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264677AbRFTXSW>; Wed, 20 Jun 2001 19:18:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264673AbRFTXSN>; Wed, 20 Jun 2001 19:18:13 -0400
Received: from sammy.netpathway.com ([208.137.139.2]:40976 "EHLO
	sammy.netpathway.com") by vger.kernel.org with ESMTP
	id <S264676AbRFTXSI>; Wed, 20 Jun 2001 19:18:08 -0400
Message-ID: <3B312AD6.38D20AFB@netpathway.com>
Date: Wed, 20 Jun 2001 17:59:34 -0500
From: "Gary White (Network Administrator)" <admin@netpathway.com>
Organization: Internet Pathway
X-Mailer: Mozilla 4.77 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.5-ac16 kernel panic
In-Reply-To: <3B3116A3.E89360DE@netpathway.com> <E15CqDS-0000DG-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-scanner: scanned by Inflex 0.1.5c - (http://www.inflex.co.za/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry I was so long getting back. I had to step out
of the office for a minute. Here is the debug message.

Initializing RT netlink socket
kernel BUG at ioremap.c:73
invalid operand: 0000



> > 2.4.5-ac16 patch applied to clean 2.4.5 tree. 2.4.5-ac15 boots
> > with no problem.
>
> Yes I screwed up the bootflag handling
>
> > EIP:    0010:[<c01112cf>]
> > EFLAGS: 00010286
> > eax: 007ec000   ebx: e0800000   ecx: 3f7ec000   edx: c0101000
>
> Can you build with kernel debug enabled and then say Y to all the debug options
> and give me the BUG() message where that next build dies. I think I know whats
> up I want to be sure
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

--
Gary White               Network Administrator
admin@netpathway.com          Internet Pathway
Voice 601-776-3355            Fax 601-776-2314


