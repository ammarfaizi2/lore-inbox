Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271790AbTGROIm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 10:08:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271760AbTGROI0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 10:08:26 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:25257
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S271761AbTGROGR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 10:06:17 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Mike Galbraith <efault@gmx.de>, Nick Piggin <piggin@cyberone.com.au>
Subject: Re: [PATCH] O6int for interactivity
Date: Sat, 19 Jul 2003 00:24:08 +1000
User-Agent: KMail/1.5.2
Cc: Davide Libenzi <davidel@xmailserver.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>
References: <5.2.1.1.2.20030718071656.01af84d0@pop.gmx.net> <5.2.1.1.2.20030718120229.01a8fcf0@pop.gmx.net>
In-Reply-To: <5.2.1.1.2.20030718120229.01a8fcf0@pop.gmx.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307190024.08571.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Jul 2003 20:18, Mike Galbraith wrote:
> At 04:34 PM 7/18/2003 +1000, Nick Piggin wrote:
> >Mike Galbraith wrote:
> That _might_ (add salt) be priorities of kernel threads dropping too low.

Is there any good reason for the priorities of kernel threads to vary at all? 
In the original design they are subject to the same interactivity changes as 
other processes and I've maintained that but I can't see a good reason for it 
and plan to change it unless someone tells me otherwise.

Con

