Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268374AbUHLDaM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268374AbUHLDaM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 23:30:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268389AbUHLDaM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 23:30:12 -0400
Received: from fmr10.intel.com ([192.55.52.30]:59882 "EHLO
	fmsfmr003.fm.intel.com") by vger.kernel.org with ESMTP
	id S268374AbUHLDaI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 23:30:08 -0400
Subject: Re: Allow userspace do something special on overtemp
From: Len Brown <len.brown@intel.com>
To: Dax Kelson <dax@gurulabs.com>
Cc: Pavel Machek <pavel@suse.cz>, trenn@suse.de, seife@suse.de,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1092269309.3948.57.camel@mentorng.gurulabs.com>
References: <20040811085326.GA11765@elf.ucw.cz>
	 <1092269309.3948.57.camel@mentorng.gurulabs.com>
Content-Type: text/plain
Organization: 
Message-Id: <1092281393.7765.141.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 11 Aug 2004 23:29:53 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I agree with Dan.

I think I'd rather see the calls to usermode deleted
instead of extended -- unless there is a reason that
the general event -> acpid method can't work.

If the administrator screws up and disables shutdown
on critical temp, modern hardware will throttle
(in hardware), and if that too fails, it will shut
itself off.

-Len


