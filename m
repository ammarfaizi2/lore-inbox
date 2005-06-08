Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261291AbVFHPFT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261291AbVFHPFT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 11:05:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261304AbVFHPFS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 11:05:18 -0400
Received: from fest.stud.feec.vutbr.cz ([147.229.72.16]:33270 "EHLO
	fest.stud.feec.vutbr.cz") by vger.kernel.org with ESMTP
	id S261291AbVFHPFC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 11:05:02 -0400
Message-ID: <42A708F7.9000803@stud.feec.vutbr.cz>
Date: Wed, 08 Jun 2005 17:04:23 +0200
From: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Paulo Marques <pmarques@grupopie.com>
CC: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       "Eugeny S. Mints" <emints@ru.mvista.com>,
       Daniel Walker <dwalker@mvista.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc6-V0.7.48-00
References: <20050608112801.GA31084@elte.hu> <42A6FE52.1050705@stud.feec.vutbr.cz> <42A7039E.7030109@grupopie.com>
In-Reply-To: <42A7039E.7030109@grupopie.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paulo Marques wrote:
> This is probably just bad luck and a known problem that I'm trying to 
> fix (but hadn't have much time lately).
> 
> Can you try to change the line:
> 
> #define WORKING_SET        1024
> 
> in scripts/kallsyms.c to:
> 
> #define WORKING_SET        65536
> 
> and disable CONFIG_KALLSYMS_EXTRA_PASS, to see if the problem goes away?

Yes, this helps.

> It it does go away, then it is the same problem, and I'm working on it...

OK, thanks.

Michal
