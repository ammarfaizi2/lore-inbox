Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261451AbVDDWSS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261451AbVDDWSS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 18:18:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261444AbVDDWOV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 18:14:21 -0400
Received: from 206.175.9.210.velocitynet.com.au ([210.9.175.206]:23718 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S261441AbVDDWM4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 18:12:56 -0400
Subject: Re: [ACPI] Re: [RFC 5/6]clean cpu state after hotremove CPU
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Nathan Lynch <ntl@pobox.com>
Cc: Li Shaohua <shaohua.li@intel.com>, lkml <linux-kernel@vger.kernel.org>,
       ACPI List <acpi-devel@lists.sourceforge.net>,
       Zwane Mwaikambo <zwane@linuxpower.ca>, Len Brown <len.brown@intel.com>,
       Pavel Machek <pavel@suse.cz>
In-Reply-To: <20050404153345.GC3611@otto>
References: <1112580367.4194.344.camel@sli10-desk.sh.intel.com>
	 <20050404052844.GB3611@otto>
	 <1112593338.4194.362.camel@sli10-desk.sh.intel.com>
	 <20050404153345.GC3611@otto>
Content-Type: text/plain
Message-Id: <1112652864.3757.31.camel@desktop.cunningham.myip.net.au>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Tue, 05 Apr 2005 08:14:25 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Tue, 2005-04-05 at 01:33, Nathan Lynch wrote:
> > Yes, exactly. Someone who understand do_exit please help clean up the
> > code. I'd like to remove the idle thread, since the smpboot code will
> > create a new idle thread.
> 
> I'd say fix the smpboot code so that it doesn't create new idle tasks
> except during boot.

Would that mean that CPUs that were physically hotplugged wouldn't get
idle threads?

Regards,

Nigel
-- 
Nigel Cunningham
Software Engineer, Canberra, Australia
http://www.cyclades.com
Bus: +61 (2) 6291 9554; Hme: +61 (2) 6292 8028;  Mob: +61 (417) 100 574

Maintainer of Suspend2 Kernel Patches http://suspend2.net

