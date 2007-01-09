Return-Path: <linux-kernel-owner+w=401wt.eu-S1751195AbXAIJdc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751195AbXAIJdc (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 04:33:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751230AbXAIJdc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 04:33:32 -0500
Received: from vms042pub.verizon.net ([206.46.252.42]:14828 "EHLO
	vms042pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751195AbXAIJdb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 04:33:31 -0500
Date: Tue, 09 Jan 2007 04:32:54 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: .version keeps being updated
In-reply-to: <20070109102057.c684cc78.khali@linux-fr.org>
To: linux-kernel@vger.kernel.org
Cc: Jean Delvare <khali@linux-fr.org>,
       Kai Germaschewski <kai@germaschewski.name>,
       Sam Ravnborg <sam@ravnborg.org>
Message-id: <200701090432.54225.gene.heskett@verizon.net>
Organization: Not detectable
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <20070109102057.c684cc78.khali@linux-fr.org>
User-Agent: KMail/1.9.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 09 January 2007 04:20, Jean Delvare wrote:
>Hi all,
>
>Since 2.6.20-rc1 or so, running "make" always builds a new kernel with
>an incremented version number, whether there has actually been any
>change done to the code or configuration or not. This increases the
>build time quite a bit.
>
>I've tracked it down to include/linux/compile.h always being updated,
>and this is because .version is updated. I couldn't find what is
>causing .version to be updated each time though. Can anybody help
>there? Was this change made on purpose or is this a bug which we should
>fix?
>
>Thanks,

I've not seen that here, Jean.  But then my 'makeit' script doesn't use a 
plain 'make' anyplace, always 'make bzimage' or 'make modules' & 'make 
modules install', etc.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2007 by Maurice Eugene Heskett, all rights reserved.
