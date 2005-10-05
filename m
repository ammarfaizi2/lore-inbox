Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030353AbVJETuM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030353AbVJETuM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 15:50:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030352AbVJETuL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 15:50:11 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:7434 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP
	id S1030351AbVJETuJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 15:50:09 -0400
Message-ID: <43442E8E.1090301@tmr.com>
Date: Wed, 05 Oct 2005 15:50:38 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050729
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: linux-kernel@vger.kernel.org, fastboot@osdl.org
Subject: Re: i386 nmi_watchdog: Merge check_nmi_watchdog fixes from x86_64
References: <m1k6gt8gvt.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m1k6gt8gvt.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:
> The per cpu nmi watchdog timer is based on an event counter.  
> idle cpus don't generate events so the NMI watchdog doesn't fire
> and the test to see if the watchdog is working fails.

Question: given all the concern about reducing clocks and all, do we 
actually need nmi on more than one CPU? Are there cases where a single 
CPU hangs in idle on an SMP system?

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
