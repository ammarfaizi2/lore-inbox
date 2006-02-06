Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932183AbWBFS4l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932183AbWBFS4l (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 13:56:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932185AbWBFS4l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 13:56:41 -0500
Received: from [81.222.97.19] ([81.222.97.19]:36576 "EHLO mail.terrhq.ru")
	by vger.kernel.org with ESMTP id S932183AbWBFS4k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 13:56:40 -0500
From: Yaroslav Rastrigin <yarick@it-territory.ru>
Organization: IT-Territory 
To: Nicolas Mailhot <nicolas.mailhot@laposte.net>
Subject: Re: Linux drivers management
Date: Mon, 6 Feb 2006 21:56:22 +0300
User-Agent: KMail/1.9
Cc: David Chow <davidchow@shaolinmicro.com>, linux-kernel@vger.kernel.org
References: <1139250712.20009.20.camel@rousalka.dyndns.org>
In-Reply-To: <1139250712.20009.20.camel@rousalka.dyndns.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602062156.22937.yarick@it-territory.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On 6 February 2006 21:31, Nicolas Mailhot wrote:
> 
> 
> Since you invoke end-users I'll answer.
> 
> This end-user is mad at hell at people like you that advocate separating
> drivers from mainline.
Huh...
> Do you really think us end-users enjoy hunting your drivers all over the
> net because you never bothered pushing them to mainline ?
He don't needs to "bother". He wrote the drivers. And you never paid him. 
(Take it, "this software is beer-free" overusers, straight in your face).
> 
[Loads of "I'm actually proving his point, but I want to be in mainstream, so..." skipped]
You have just nicely proved all the stable API pros. 'Cause when interfaces are clearly defined, described and implemented 
according to documentation, you won't need to even recompile (in case of ABI compatibility) or 
search for newer driver version, if your current version works nicely. You don't need to lay burden of sifting through and fixing 
metric boatloads of code when internals change onto changemaker's shoulders, 'cause everything what he needs to be concerned about is 
API compatibility. And if some particular driver worked with 2.x.xx but the same driver source fails to work on 2.x.xx+1 - 
you know where to search and what to do. And driver vendors could concentrate on improving driver cores, 
instead of rewriting interfaces. And kernel developers could concentrate on developing kernel features, instead of thinking 
"I'll introduce changes in this subsystem, this change will certainly affect IDE, SCSI, networking and may touch firewalling code" and 
spending O(N!) time modifying all affected device drivers' source by himself, instead of O(N)/O(1). And average patchset 
size will shrink by order of magnitude for medium changes. And...


> 
> But do not invoke end-users. Or end users will answer you.
> 
They ARE answering already. 
-- 
Managing your Territory since the dawn of times ...
