Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964925AbWFNNgG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964925AbWFNNgG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 09:36:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964928AbWFNNgG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 09:36:06 -0400
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:52388 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP id S964925AbWFNNgE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 09:36:04 -0400
Message-ID: <44901159.30502@bull.net>
Date: Wed, 14 Jun 2006 15:38:33 +0200
From: Pierre Peiffer <pierre.peiffer@bull.net>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: =?ISO-8859-15?Q?S=E9bastien_Dugu=E9?= <sebastien.dugue@bull.net>
Cc: Jakub Jelinek <jakub@redhat.com>, Arjan van de Ven <arjan@infradead.org>,
       Ingo Molnar <mingo@redhat.com>, Atsushi Nemoto <anemo@mba.ocn.ne.jp>,
       Ulrich Drepper <drepper@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: NPTL mutex and the scheduling priority
References: <20060612.171035.108739746.nemoto@toshiba-tops.co.jp>	 <1150115008.3131.106.camel@laptopd505.fenrus.org>	 <20060612124406.GZ3115@devserv.devel.redhat.com>	 <1150125869.3835.12.camel@frecb000686>	 <20060613084819.GL3115@devserv.devel.redhat.com>	 <1150200272.3835.33.camel@frecb000686>	 <20060613125603.GQ3115@devserv.devel.redhat.com> <1150291180.3835.59.camel@frecb000686>
In-Reply-To: <1150291180.3835.59.camel@frecb000686>
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 14/06/2006 15:39:49,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 14/06/2006 15:39:49,
	Serialize complete at 14/06/2006 15:39:49
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sébastien Dugué a écrit :

> 
>> FUTEX_REQUEUE is used by pthread_cond_signal to requeue the __data.__futex
>> onto __data.__lock.
> 
>   You meant FUTEX_WAKE_OP, I guess. I could not find any place still 
> using FUTEX_REQUEUE in glibc 2.4.

... FUTEX_CMP_REQUEUE ... ;-)

FUTEX_REQUEUE is obsolote ...

-- 
Pierre P.
