Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261784AbVAYDdA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261784AbVAYDdA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 22:33:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261788AbVAYDdA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 22:33:00 -0500
Received: from fmr14.intel.com ([192.55.52.68]:25245 "EHLO
	fmsfmr002.fm.intel.com") by vger.kernel.org with ESMTP
	id S261784AbVAYDc6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 22:32:58 -0500
Subject: Re: [PATCH 4/29] x86-i8259-shutdown
From: Len Brown <len.brown@intel.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@osdl.org>, fastboot@lists.osdl.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <x86-i8259-shutdown-11061198973856@ebiederm.dsl.xmission.com>
References: <x86-i8259-shutdown-11061198973856@ebiederm.dsl.xmission.com>
Content-Type: text/plain
Organization: 
Message-Id: <1106623970.2399.205.camel@d845pe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 24 Jan 2005 22:32:50 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-01-19 at 02:31, Eric W. Biederman wrote:
> From: Eric W. Biederman <ebiederm@xmission.com>
> 
> This patch disables interrupt generation from the legacy pic on
> reboot.  Now that there is a sys_device class it should not be called
> while drivers are still using interrupts.
> 
> There is a report about this breaking ACPI power off on some systems.
> http://bugme.osdl.org/show_bug.cgi?id=4041
> However the final comment seems to exhonorate this code.  So until
> I get more information I believe that was a false positive.

No, the last comment in the bug report
(davej says that there were poweroff problems in FC)
does not exhonerate this patch.
All it says is that there are additional poweroff bugs out there.

-Len


