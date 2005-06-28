Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261975AbVF1GjC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261975AbVF1GjC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 02:39:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261633AbVF1GhJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 02:37:09 -0400
Received: from b3162.static.pacific.net.au ([203.143.238.98]:33962 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S261975AbVF1G3N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 02:29:13 -0400
Subject: Re: [PATCH]MTRR suspend/resume cleanup
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Li Shaohua <shaohua.li@intel.com>
Cc: lkml <linux-kernel@vger.kernel.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>, ak <ak@muc.de>,
       Pavel Machek <pavel@ucw.cz>, akpm <akpm@osdl.org>
In-Reply-To: <1119936124.3158.9.camel@linux-hp.sh.intel.com>
References: <1119936124.3158.9.camel@linux-hp.sh.intel.com>
Content-Type: text/plain
Organization: Cycades
Message-Id: <1119940228.7513.18.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Tue, 28 Jun 2005 16:30:28 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Tue, 2005-06-28 at 15:22, Shaohua Li wrote:
> Hi,
> There has been some discuss about solving the SMP MTRR suspend/resume
> breakage, but I didn't find a patch for it. This is an intent for it.
> The basic idea is moving mtrr initializing into cpu_identify for all APs
> (so it works for cpu hotplug). For BP, restore_processor_state is
> responsible for restoring MTRR.

I have a patch in Suspend2 that removes the sysdev drivers and
implements mtrr save & restore as part of the cpu state save/restore.
I'm not sure if that's what you were thinking of.

I'm not using hotplug CPU at the moment, so won't be trying your patch
at the moment sorry.

Regards,

Nigel 

