Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262601AbTEVI2X (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 04:28:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262609AbTEVI2W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 04:28:22 -0400
Received: from lindsey.linux-systeme.com ([80.190.48.67]:7940 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S262601AbTEVI2U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 04:28:20 -0400
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: "David Lewis" <dlewis@vnxsolutions.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [OOPS] kswapd 2.4.20
Date: Thu, 22 May 2003 10:41:14 +0200
User-Agent: KMail/1.5.1
Cc: "Erin Britz" <ebritz@vnxsolutions.com>
References: <EMEOIBCHEHCPNABJGHGOCEJBCNAA.dlewis@vnxsolutions.com>
In-Reply-To: <EMEOIBCHEHCPNABJGHGOCEJBCNAA.dlewis@vnxsolutions.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200305221027.00184.m.c.p@wolk-project.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 21 May 2003 16:45, David Lewis wrote:

Hi David,

> Fourth one sent to list.. Please advise if any other information is needed.
> A reply would be appreciated even if it is to say that this is the wrong
> place.
> May 21 03:23:50 nicebox kernel: Unable to handle kernel paging request at
> virtual address 938a909e
> May 21 03:23:50 nicebox kernel: Process kswapd (pid: 5, stackpage=df6d5000)
I really don't know how often I've seen this in recent 2.4 kernels 
(.17,.18,.19,.20 (mainstream) and so on).

For me, I use the rmap VM. The problem is eliminated in that tree. Also the 
-aa VM does not have that problem.

I am pretty sure Andrea sent a fix for this issue more than once a while ago 
to the list cc'ed Marcelo (correct me if I am wrong), but to quote Andrea:
"We are here to fix bugs. If bug fixes are not accepted we can stop right here 
to fix bugs".

ciao, Marc
