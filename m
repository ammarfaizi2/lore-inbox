Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751154AbWAZEx4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751154AbWAZEx4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 23:53:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751293AbWAZEx4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 23:53:56 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:52139 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751154AbWAZExz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 23:53:55 -0500
Subject: Re: pthread_mutex_unlock (was Re: sched_yield() makes OpenLDAP
	slow)
From: Lee Revell <rlrevell@joe-job.com>
To: Samuel Masham <samuel.masham@gmail.com>
Cc: davids@webmaster.com, lkml@rtr.ca,
       Christopher Friesen <cfriesen@nortel.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       hancockr@shaw.ca
In-Reply-To: <93564eb70601252002x5949b65fs@mail.gmail.com>
References: <43D8386B.6000204@rtr.ca>
	 <MDEHLPKNGKAHNMBLJOLKGEJPJKAB.davids@webmaster.com>
	 <93564eb70601251949r1fb4c209t@mail.gmail.com>
	 <93564eb70601252002x5949b65fs@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 25 Jan 2006 23:53:53 -0500
Message-Id: <1138251234.3087.107.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-01-26 at 13:02 +0900, Samuel Masham wrote:
> On 26/01/06, Samuel Masham <samuel.masham@gmail.com> wrote:
> > comment:
> > As a rt person I don't like the idea of scheduler bounce so the way
> > round seems to be have the mutex lock acquiring work on a FIFO like
> > basis.
> 
> which is obviously wrong...
> 
> Howeve my basic point stands but needs to be clarified a bit:
> 
> I think I can print non-compliant if the mutex acquisition doesn't
> respect the higher priority of the waiter over the current process
> even if the mutex is "available".
> 
> OK?

I don't think using an optional feature (PI) counts...

Lee

