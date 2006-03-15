Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751378AbWCOKTn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751378AbWCOKTn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 05:19:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751472AbWCOKTn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 05:19:43 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:23975
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S1751378AbWCOKTm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 05:19:42 -0500
Message-ID: <4417EA34.20802@tglx.de>
Date: Wed, 15 Mar 2006 11:19:32 +0100
From: Jan Altenberg <tb10alj@tglx.de>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
Cc: karsten wiese <annabellesgarden@yahoo.de>,
       Rui Nuno Capela <rncbc@rncbc.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] realtime-preempt patch-2.6.15-rt19 compile error (was:
      realtime-preempt patch-2.6.15-rt18 issues)
References: <36944.195.245.190.93.1141734835.squirrel@www.rncbc.org> <20060314231344.44688.qmail@web26506.mail.ukl.yahoo.com> <20060315093122.GA1682@elte.hu>
In-Reply-To: <20060315093122.GA1682@elte.hu>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> a better fix would be the one below - it still does the call on the 
> current CPU, and skips other CPUs (on SMP). Does this solve the problem 
> on your box too?

Tested in all a hurry and it seems to work for me too.

Cheers,
JAN
