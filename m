Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750948AbWDMP4v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750948AbWDMP4v (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 11:56:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750979AbWDMP4v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 11:56:51 -0400
Received: from dvhart.com ([64.146.134.43]:60876 "EHLO dvhart.com")
	by vger.kernel.org with ESMTP id S1750948AbWDMP4u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 11:56:50 -0400
Message-ID: <443E74C1.5090801@mbligh.org>
Date: Thu, 13 Apr 2006 08:56:49 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: K P <kplkml@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: JVM performance on Linux (vs. Solaris/Windows)
References: <62a080740604130753i4b8bbbckc3cba12092b54226@mail.gmail.com>
In-Reply-To: <62a080740604130753i4b8bbbckc3cba12092b54226@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

K P wrote:

>Sun's recently published SPECjbb_2005 numbers on Linux, Windows and
>Solaris on their
>Opteron system, and the Linux result is the lowest of the three by far:
>
>Linux: http://www.spec.org/jbb2005/results/res2006q1/jbb2005-20060117-00062.html
>Solaris: http://www.spec.org/jbb2005/results/res2006q1/jbb2005-20060117-00063.html
>Windows: http://www.spec.org/jbb2005/results/res2006q1/jbb2005-20060117-00064.html
>
>It's not evident if Sun spent any time analyzing and tuning the Linux
>result. While the
>majority of the tuning opportunities for SPECjbb_2005 are likely to be
>in the JVM itself, I was
>wondering (given the large spread between the OS's) if there were
>other typical opportunities
>to tune the Linux kernel for JVM performance and SPECjbb_2005.
>
>There are some other results showing excellent scalability with SPECjbb_2005 on
>Linux/Itanium (such as SGI's:
>http://www.spec.org/jbb2005/results/res2006q2/ ), but it's
>not clear if there are other opportunities for tuning unique to Linux
>on Opteron, or Linux
>in general that should be explored
>
>Comments?
>  
>

SpecJBB is a really frigging stupid benchmark. It's *much* more affected
by the stupid crap in Java (like their locking model) than anything in the
OS. 

Best to find another benchmark, oh and preferably somebody vaguely
objective to run it ;-)

M.

