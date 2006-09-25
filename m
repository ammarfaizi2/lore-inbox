Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751438AbWIYSYH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751438AbWIYSYH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 14:24:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751459AbWIYSYH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 14:24:07 -0400
Received: from mx1.redhat.com ([66.187.233.31]:49645 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751438AbWIYSYF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 14:24:05 -0400
Date: Mon, 25 Sep 2006 14:23:47 -0400
From: Dave Jones <davej@redhat.com>
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Cc: Ismail Donmez <ismail@pardus.org.tr>, LKML <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: New section mismatch warning on latest linux-2.6 git tree
Message-ID: <20060925182347.GB9683@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	"Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
	Ismail Donmez <ismail@pardus.org.tr>,
	LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
References: <EB12A50964762B4D8111D55B764A8454A41360@scsmsx413.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <EB12A50964762B4D8111D55B764A8454A41360@scsmsx413.amr.corp.intel.com>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 25, 2006 at 10:51:54AM -0700, Pallipadi, Venkatesh wrote:

 > >This seems to be pretty new :
 > >
 > >WARNING: arch/i386/kernel/cpu/cpufreq/speedstep-centrino.o - 
 > >Section mismatch: 
 > >reference to .init.text: from .data between 
 > >'sw_any_bug_dmi_table' (at offset 
 > >0x320) and 'centrino_attr'
 > >
 > >Using Linus' latest git tree.
 > >
 > >Regards,
 > >ismail
 > 
 > Andrew,
 > 
 > Can you please push the patch from Jeremy here:
 > 
 > http://www.ussg.iu.edu/hypermail/linux/kernel/0609.1/1389.html

That's the patch that has caused this situation.
Andrew had it in -mm until recently, when I merged it into cpufreq.git.
And now, Linus has pulled it into mainline.

	Dave
