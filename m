Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272158AbTHIAjn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 20:39:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272140AbTHIAjP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 20:39:15 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:6876
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S272216AbTHIAiy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 20:38:54 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Timothy Miller <miller@techsource.com>
Subject: Re: [PATCH]O14int
Date: Sat, 9 Aug 2003 10:44:16 +1000
User-Agent: KMail/1.5.3
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <200308090149.25688.kernel@kolivas.org> <3F33E46D.9040508@techsource.com>
In-Reply-To: <3F33E46D.9040508@techsource.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308091044.16296.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 9 Aug 2003 03:57, Timothy Miller wrote:
> Con Kolivas wrote:
> > Made highly interactive tasks earn all their waiting time on the runqueue
> > during requeuing as sleep_avg.
>
> There are some mechanics of this that I am not familiar with, so please
> excuse the naive question.
>
> Someone had suggested that a task's sleep time should be determine
> exclusively from the time it spends blocked by what it's waiting on, and
> not based on any OTHER time it sleeps.  That is, the time between the
> I/O request being satisfied and the task actually getting the CPU
> doesn't count.
>
> Is your statement above a reflection of that suggestion?

I have already been doing this in previous iterations to the extent that it 
was capable of being done. There's only so much information feeding into the 
scheduler at the moment. All the dependent subsections would have to have 
more code to have specific feedback to the scheduler.

Con

