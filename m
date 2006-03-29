Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750912AbWC2TyM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750912AbWC2TyM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 14:54:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750913AbWC2TyM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 14:54:12 -0500
Received: from mcr-smtp-001.bulldogdsl.com ([212.158.248.7]:2056 "EHLO
	mcr-smtp-001.bulldogdsl.com") by vger.kernel.org with ESMTP
	id S1750908AbWC2TyL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 14:54:11 -0500
X-Spam-Abuse: Please report all spam/abuse matters to abuse@bulldogdsl.com
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: JimD <Jim@keeliegirl.dyndns.org>
Subject: Re: AMD64 overclock issue with 2.6.16 but not with 2.6.15
Date: Wed, 29 Mar 2006 20:54:09 +0100
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
References: <20060329143523.3bbb4df7@keelie.localdomain>
In-Reply-To: <20060329143523.3bbb4df7@keelie.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603292054.09385.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 29 March 2006 20:35, JimD wrote:
> Do any one know of any other issues with amd64 and the
> 2.6.16 series?  I have run into a weird issue.
[snip]
> The bogomips are showing the same though the kernel is not reporting
> the correct MHz.  If I reboot and check the BIOS, the correct MHz is
> reported.  I have not run any CPU benchmarks to see if performance is
> really going back down to 2000 MHz.
>
> Does anyone have a clue what could be causing this?

At a guess, it sounds like you're trying to use cpufreq on an overclocked CPU, 
a definitely no-no. Check your config for this option, remove it if desired.

-- 
Cheers,
Alistair.

'No sense being pessimistic, it probably wouldn't work anyway.'
Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
