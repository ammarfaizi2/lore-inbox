Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964906AbWDDAMN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964906AbWDDAMN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 20:12:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964907AbWDDAMM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 20:12:12 -0400
Received: from mail28.syd.optusnet.com.au ([211.29.133.169]:53457 "EHLO
	mail28.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S964906AbWDDAMM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 20:12:12 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Peter Williams <pwil3058@bigpond.net.au>
Subject: Re: [ANNOUNCE][RFC] PlugSched-6.3.1 for  2.6.16-rc5
Date: Tue, 4 Apr 2006 10:12:04 +1000
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, Al Boldi <a1426z@gawab.com>
References: <200604031459.51542.a1426z@gawab.com> <200604040929.48198.kernel@kolivas.org> <4431B756.3080101@bigpond.net.au>
In-Reply-To: <4431B756.3080101@bigpond.net.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604041012.04591.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 04 April 2006 10:01, Peter Williams wrote:
> Con Kolivas wrote:
> > On Tuesday 04 April 2006 09:04, Peter Williams wrote:
> >> Al Boldi wrote:
> >>> Also, different schedulers per cpu could be rather useful.
> >>> Peter Williams wrote:
> >>
> >> I think that would be dangerous.  However, different schedulers per
> >> cpuset might make sense but it involve a fair bit of work.
> >
> > I'm curious. How do you think different schedulers per cpu would be
> > useful?
>
> I don't but I think they MIGHT make sense for cpusets e.g. one set with
> a scheduler targeted at interactive tasks and another targeted at server
> tasks.  NB the emphasis on might.

I am curious as to Al's answer since he asked for the feature. It would be 
easy for me to modify the staircase cpu scheduler to allow the interactive 
and compute modes be set on a per-cpu basis if that was desired. For that to 
be helpful of course you'd have to manually set affinity for the tasks or 
logins you wanted to run on each cpu(s).

Cheers,
Con
