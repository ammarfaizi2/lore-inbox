Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262747AbVBYRIo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262747AbVBYRIo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Feb 2005 12:08:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262750AbVBYRIo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Feb 2005 12:08:44 -0500
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:52371 "EHLO
	zcars04e.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S262747AbVBYRIl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Feb 2005 12:08:41 -0500
Message-ID: <421F5B5F.7040503@nortel.com>
Date: Fri, 25 Feb 2005 11:07:43 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
CC: Paulo Marques <pmarques@grupopie.com>, Ingo Oeser <ioe-lkml@axxeo.de>,
       "Chad N. Tindel" <chad@tindel.net>, Mike Galbraith <EFAULT@gmx.de>,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: Xterm Hangs - Possible scheduler defect?
References: <20050224075756.GA18639@calma.pair.com>	 <200502250151.41793.ioe-lkml@axxeo.de> <421F4042.3020302@nortel.com>	 <200502251639.50238.ioe-lkml@axxeo.de>  <421F49E0.9090806@grupopie.com> <1109348667.9681.10.camel@krustophenia.net>
In-Reply-To: <1109348667.9681.10.camel@krustophenia.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell wrote:

> The solution to your problem (which is as old as the hills) involves
> priority inheriting mutexes which are available in the RT preempt patch
> (if you build with CONFIG_PREEMPT_RT).  This should be usable for hard
> realtime applications.

Yup.  I was just pointing out that userspace apps *can* block other 
userspace apps.

> http://people.redhat.com/mingo/realtime-preempt
> 
> If you just need very good soft realtime performance I recommend
> PREEMPT_DESKTOP.

How does this compare with Inaky's "robust mutexes" patch?

Chris

