Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751163AbVHQQVA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751163AbVHQQVA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 12:21:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751164AbVHQQVA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 12:21:00 -0400
Received: from mail.aknet.ru ([82.179.72.26]:26884 "EHLO mail.aknet.ru")
	by vger.kernel.org with ESMTP id S1751163AbVHQQU7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 12:20:59 -0400
Message-ID: <430363F2.7090009@aknet.ru>
Date: Wed, 17 Aug 2005 20:21:06 +0400
From: Stas Sergeev <stsp@aknet.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041020
X-Accept-Language: ru, en-us, en
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
Cc: john stultz <johnstul@us.ibm.com>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [rfc][patch] API for timer hooks
References: <42FDF744.2070205@aknet.ru>	 <1124126354.8630.3.camel@cog.beaverton.ibm.com> <43024ADA.8030508@aknet.ru> <1124244580.30036.5.camel@mindpipe>
In-Reply-To: <1124244580.30036.5.camel@mindpipe>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

Lee Revell wrote:
> Wow, your driver implements bass and treble controls by varying the
> frequency of the timer interrupt.  That's a neat hack, but I'd expect it
> to raise a few eyebrows if it's submitted for mainline...
I realized that some time ago, and now,
even though the code it still there,
the treble/bass controls are no longer
exported to the mixer. The driver now
works on a fixed frequency. Well, you
can still select one of the two base
frequencies, but if need be, I can
disallow also this. I am willing to
reduce the requirements as much as possible,
as long as it will help getting the thing
in, but perhaps allowing a single higher
frequency, or allowing just any frequency,
is pretty much the same task, and doesn't
look achievable within the currently existing
timer API anyway.

