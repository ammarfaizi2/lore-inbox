Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750881AbWELWuX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750881AbWELWuX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 18:50:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751125AbWELWuX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 18:50:23 -0400
Received: from mail.gmx.net ([213.165.64.20]:36001 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750881AbWELWuX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 18:50:23 -0400
X-Authenticated: #31060655
Message-ID: <446510DA.1030106@gmx.net>
Date: Sat, 13 May 2006 00:48:58 +0200
From: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2006@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.1) Gecko/20060316 SUSE/1.0-27 SeaMonkey/1.0
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Pavel Machek <pavel@suse.cz>, linux-kernel@vger.kernel.org, trenn@suse.de,
       thoenig@suse.de
Subject: Re: [patch] smbus unhiding kills thermal management
References: <20060512095343.GA28375@elf.ucw.cz> <20060512112742.5ab21993.akpm@osdl.org>
In-Reply-To: <20060512112742.5ab21993.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Pavel Machek <pavel@suse.cz> wrote:
>> Do not enable the SMBus device on Asus boards if suspend
>>  is used. We do not reenable the device on resume, leading to all sorts
>>  of undesirable effects, the worst being a total fan failure after
>>  resume on Samsung P35 laptop.
>>
>>  Signed-off-by: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2006@gmx.net>
>>  Signed-off-by: Pavel Machek <pavel@suse.cz>
>>
>>  ---
>>  commit f14c852a8cb7483ce0e1e0e05ef49fed2f67103b
>>  tree ab0cbe41b344a62bc81dd5cb093e3b6062c12556
>>  parent 392dbe84f1e484b1e48036ca266cb826fd34f8da
>>  author <pavel@amd.ucw.cz> Fri, 12 May 2006 11:50:00 +0200
>>  committer <pavel@amd.ucw.cz> Fri, 12 May 2006 11:50:00 +0200
> 
> Are these attributions correct, or did Carl-Daniel write it?

I tracked down the bug and provided the patch.
Pavel changed it to use the correct config option.


Regards,
Carl-Daniel
-- 
http://www.hailfinger.org/
