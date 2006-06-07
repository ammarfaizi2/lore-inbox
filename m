Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932375AbWFGVbM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932375AbWFGVbM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 17:31:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932424AbWFGVbM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 17:31:12 -0400
Received: from gw.goop.org ([64.81.55.164]:16340 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S932375AbWFGVbM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 17:31:12 -0400
Message-ID: <44872091.5000701@goop.org>
Date: Wed, 07 Jun 2006 11:53:05 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Don Zickus <dzickus@redhat.com>
CC: Shaohua Li <shaohua.li@intel.com>, Miles Lane <miles.lane@gmail.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, ak@suse.de
Subject: Re: [2.6.17-rc5-mm2] crash when doing second suspend: BUG in	arch/i386/kernel/nmi.c:174
References: <4480C102.3060400@goop.org> <4483DF32.4090608@goop.org> <20060605004823.566b266c.akpm@osdl.org> <a44ae5cd0606050135w66c2abeu698394b4268e4790@mail.gmail.com> <1149576246.32046.166.camel@sli10-desk.sh.intel.com> <4485AC1F.9050001@goop.org> <20060607024938.GG11696@redhat.com> <448707DA.9090801@goop.org> <20060607175018.GU2839@redhat.com>
In-Reply-To: <20060607175018.GU2839@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Don Zickus wrote:
> Can you do me a quick favor and 'cat /proc/interrupts |grep NMI' before
> each of your suspends.  I want to double check a piece of code.  Your
> bugzilla postings showed your system starting with no nmi watchdog running
> but after the resume the watchdog started running on cpu1.  I am hoping I
> fixed that issue too.
>   
Yes, there are no NMIs on either CPU after resume.

    J

