Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316803AbSGLTro>; Fri, 12 Jul 2002 15:47:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316820AbSGLTrn>; Fri, 12 Jul 2002 15:47:43 -0400
Received: from holomorphy.com ([66.224.33.161]:45982 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S316803AbSGLTrn>;
	Fri, 12 Jul 2002 15:47:43 -0400
Date: Fri, 12 Jul 2002 12:49:24 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Hanna Linder <hannal@us.ibm.com>, lse-tech@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [Lse-tech] Minutes from LSE Con Call
Message-ID: <20020712194924.GT25360@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Hanna Linder <hannal@us.ibm.com>, lse-tech@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
References: <29610000.1026499086@w-hlinder> <20020712194028.GR25360@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <20020712194028.GR25360@holomorphy.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 12, 2002 at 12:40:28PM -0700, William Lee Irwin III wrote:
> (3) CONFIG_PREEMPT calls preempt_schedule() on secondaries
> 	before they're ready, and the exception is flagged as
> 	no vm86_info: BAD
> 	Didn't want to go to deep into it at 3AM and disabled preempt.

Sorry, I forgot to mention that preempt_schedule() was called from
printk(), specifically, release_console_sem().


Cheers,
Bill
