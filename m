Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262434AbTJITmE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 15:42:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262439AbTJITmE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 15:42:04 -0400
Received: from smtp1.clear.net.nz ([203.97.33.27]:2722 "EHLO
	smtp1.clear.net.nz") by vger.kernel.org with ESMTP id S262434AbTJITlk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 15:41:40 -0400
Date: Fri, 10 Oct 2003 08:39:36 +1300
From: Nigel Cunningham <ncunningham@clear.net.nz>
Subject: Re: pmdisk performance problem
In-reply-to: <87k77ejkfp.fsf@mcs.anl.gov>
To: Narayan Desai <desai@mcs.anl.gov>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <1065728376.7981.7.camel@laptop-linux>
Organization: 
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.2.2
Content-type: text/plain
Content-transfer-encoding: 7bit
References: <87k77ejkfp.fsf@mcs.anl.gov>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For the clock issue, you need to run /sbin/hwclock --hctosys post resume
(this is not a bug in Software Suspend).

Regards,

Nigel

On Fri, 2003-10-10 at 08:11, Narayan Desai wrote:
> When using 2.6.0-test7 on an ibm thinkpad t21, pmdisk works properly,
> though it takes quite a while to write out pages to disk. On my last
> suspend to disk, it took on the order of 8-10 minutes. After this
> completed, i was able to successfully resume, fairly speedily, however
> my hardware clock was 8-10 minutes behind. Does anyone have any ideas
> why this is happening? thanks...
>  -nld
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
Nigel Cunningham
495 St Georges Road South, Hastings 4201, New Zealand

Evolution (n): A process whereby infinitely improbable events occur with
alarming frequency, order arises from chaos, and no one is given credit.

