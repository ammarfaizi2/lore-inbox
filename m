Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266860AbUGVRw4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266860AbUGVRw4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jul 2004 13:52:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266862AbUGVRw4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jul 2004 13:52:56 -0400
Received: from LPBPRODUCTIONS.COM ([68.98.211.131]:61639 "HELO
	lpbproductions.com") by vger.kernel.org with SMTP id S266860AbUGVRwz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jul 2004 13:52:55 -0400
From: Matt Heler <lkml@lpbproductions.com>
Reply-To: lkml@lpbproduction.scom
To: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Subject: Re: voluntary-preempt I0: sluggish feel
Date: Thu, 22 Jul 2004 10:52:54 -0700
User-Agent: KMail/1.6.82
References: <20040721053007.GA8376@elte.hu> <20040722161941.GA23972@elte.hu> <20040722172428.GA5632@ss1000.ms.mff.cuni.cz>
In-Reply-To: <20040722172428.GA5632@ss1000.ms.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200407221052.54470.lkml@lpbproductions.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I can confirm the same problem here.

Matt H.

On Thursday 22 July 2004 10:24 am, Rudo Thomas wrote:
> > thx for the report - i fixed this in the -I0 patch:
> >
> >  
> > http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.8-rc2-I0
> >
> > (the problem only occured when CONFIG_PREEMPT was enabled.)
>
> Hello again.
>
> Indeed, no more `scheduling while atomic'.
>
> OTOH, now the system feels terribly slow when voluntary_preemption is set
> to 2. Setting it to 0 or 1 makes the sluggish feel go away.
>
> Rudo.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
