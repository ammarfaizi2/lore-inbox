Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932153AbWDOXAF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932153AbWDOXAF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Apr 2006 19:00:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932513AbWDOXAF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Apr 2006 19:00:05 -0400
Received: from smtp-out.google.com ([216.239.45.12]:41540 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP id S932153AbWDOXAD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Apr 2006 19:00:03 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:user-agent:
	x-accept-language:mime-version:to:cc:subject:references:in-reply-to:
	content-type:content-transfer-encoding;
	b=nsq7hrAZK7j+/vXrkrMX11/svY8XGe72nfpyYG9MjA9ZepNKoivK5n0GC1ksHNmE1
	WiQ7C2QTWNZitdgzzfZHw==
Message-ID: <44417ADB.4070104@google.com>
Date: Sat, 15 Apr 2006 15:59:39 -0700
From: "Martin J. Bligh" <mbligh@google.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, apw@shadowen.org,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: Clear performance regression on reaim7 in 2.6.15-git6
References: <4441452F.3060009@google.com>	<20060415141744.042231a8.akpm@osdl.org>	<44416616.10908@google.com>	<20060415145227.5d1249bd.akpm@osdl.org>	<444173EE.4060602@google.com> <20060415154518.6a5a0c52.akpm@osdl.org>
In-Reply-To: <20060415154518.6a5a0c52.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>It's still broken in 17-rc1 ... will send you a patch in a sec.
> 
> 
> I already have kconfigdebug-set-debug_mutex-to-off-by-default.patch queued up.

OK. That explains why -mm2 bounced back at the end of this graph:
http://test.kernel.org/perf/reaim.moe.png

But ... it's still way below what 2.6.15 was. There's another thunk
down between 2.6.16 and 2.6.16-git18, AFAICS.

M.
