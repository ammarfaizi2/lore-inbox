Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267324AbUJITjP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267324AbUJITjP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Oct 2004 15:39:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267333AbUJITjH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Oct 2004 15:39:07 -0400
Received: from main.gmane.org ([80.91.229.2]:5600 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S267324AbUJITiz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Oct 2004 15:38:55 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@mru.ath.cx>
Subject: Re: [ANNOUNCE] Linux 2.6 Real Time Kernel
Date: Sat, 09 Oct 2004 21:38:41 +0200
Message-ID: <yw1xvfdjadha.fsf@mru.ath.cx>
References: <41677E4D.1030403@mvista.com> <416822B7.5050206@opersys.com>
 <1097346628.1428.11.camel@krustophenia.net>
 <20041009212614.GA25441@tier.local>
 <1097350227.1428.41.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 197.80-202-92.nextgentel.com
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
Cancel-Lock: sha1:E8b0XazoLhwa+r6p/pPC/M5Xb4w=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell <rlrevell@joe-job.com> writes:

>> > > To the best of my understanding, this still doesn't provide
>> > > deterministic hard-real-time performance in Linux.
>> > 
>> > Using only the VP+IRQ thread patch, I ran my RT app for 11 million
>> > cycles yesterday, with a maximum delay of 190 usecs.  How would this not
>> > satisfy a 200 usec hard RT constraint?
>> 
>> I think the keyword here is "deterministic", isn't it?
>
> Well, depends what you mean by deterministic.  Some RT apps only require
> an upper bound on response time.  This is a form of determinism.

Sure, but running for a zillion cycles without breaking some limit
doesn't guarantee that it never will happen.  Being able to give such
a guarantee is what determinism is about.

-- 
Måns Rullgård
mru@mru.ath.cx

