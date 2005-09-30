Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030345AbVI3Pwv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030345AbVI3Pwv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 11:52:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030346AbVI3Pwv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 11:52:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:13781 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030345AbVI3Pwu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 11:52:50 -0400
Message-ID: <433D4428.3050906@suse.de>
Date: Fri, 30 Sep 2005 15:56:56 +0200
From: Stefan Seyfried <seife@suse.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.10) Gecko/20050715 Thunderbird/1.0.6 Mnenhy/0.7.2.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Jones <davej@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, cpufreq@lists.linux.org.uk,
       alex-kernel@digriz.org.uk, Alexander Clouter <alex@digriz.org.uk>,
       LKML <linux-kernel@vger.kernel.org>,
       Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [patch 1/1] cpufreq_conservative: invert meaning of   'ignore_nice'
References: <20050929084435.GC3169@inskipp.digriz.org.uk>	<200509291346.33855.blaisorblade@yahoo.it> <20050929215153.GF31516@redhat.com>
In-Reply-To: <20050929215153.GF31516@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:
> On Thu, Sep 29, 2005 at 01:46:33PM +0200, Blaisorblade wrote:

>  > So userspace tools will error out rather than do the reverse of what they were 
>  > doing, and the user will fix the thing according to the (new) docs.
> 
> Agreed. If we change this, we change it completely.
> Stefan already mentioned his app will break, and we typically don't
> find out about widespread breakage until after we ship a release.

I can live with the change - powersaved has a setting "consider_nice" to
configure this and i can put out a support article telling people to
"invert" this setting if they are running custom kernels, so it is not
really a showstopper for me. Most of the users don't understand thos
settings anyway ;-)

I'm not sure what is better for me - a nice short name or a clear
indication on which version we are running ;-)
-- 
Stefan Seyfried                  \ "I didn't want to write for pay. I
QA / R&D Team Mobile Devices      \ wanted to be paid for what I write."
SUSE LINUX Products GmbH, Nürnberg \                    -- Leonard Cohen

