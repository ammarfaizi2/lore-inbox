Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268596AbUHLPxA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268596AbUHLPxA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 11:53:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268597AbUHLPxA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 11:53:00 -0400
Received: from cantor.suse.de ([195.135.220.2]:24999 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S268596AbUHLPwx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 11:52:53 -0400
Message-ID: <411B91B9.6020200@suse.de>
Date: Thu, 12 Aug 2004 17:50:17 +0200
From: Stefan Seyfried <seife@suse.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040804
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: Len Brown <len.brown@intel.com>, Pavel Machek <pavel@suse.cz>,
       Thomas Renninger <trenn@suse.de>, linux-kernel@vger.kernel.org,
       acpi-devel@lists.sourceforge.net
Subject: Re: Allow userspace do something special on overtemp
References: <20040811085326.GA11765@elf.ucw.cz>	<1092323945.5028.177.camel@dhcppc4> <20040812081634.532e3fc7.rddunlap@osdl.org>
In-Reply-To: <20040812081634.532e3fc7.rddunlap@osdl.org>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy.Dunlap wrote:
> On 12 Aug 2004 11:19:05 -0400 Len Brown wrote:
> 
> | Simpler to delete the usermode call and rely on the (flexible)
> | acpid event, yes?
> | 
> |  thermal.c |   29 +----------------------------
> |  1 files changed, 1 insertion(+), 28 deletions(-)
> 
> a.  Yes, it should be more flexible than just 'overtemp'.
> 
> b.  For userspace, there are:
> 
> acpid -  http://sourceforge.net/projects/acpid/
> 
> acpi tools, like ospmd (by Andy Grover) - in CVS at
>   http://sourceforge.net/projects/acpi/
> 
> What others are there?

powersaved - http://forge.novell.com/modules/xfmod/project/?powersave
handles APM, ACPI and cpufreq
-- 
seife

"Any ideas, John?"
"Well, surrounding thems out."
