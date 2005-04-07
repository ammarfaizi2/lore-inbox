Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262478AbVDGObT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262478AbVDGObT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 10:31:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262469AbVDGObT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 10:31:19 -0400
Received: from hades.almg.gov.br ([200.198.60.36]:31392 "EHLO
	hades.almg.gov.br") by vger.kernel.org with ESMTP id S262478AbVDGObP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 10:31:15 -0400
Message-ID: <42554407.4010200@almg.gov.br>
Date: Thu, 07 Apr 2005 11:30:31 -0300
From: Humberto Massa <humberto.massa@almg.gov.br>
User-Agent: Mozilla Thunderbird 1.0+ (Windows/20050224)
MIME-Version: 1.0
To: linux-os@analogic.com, debian-kernel@lists.debian.org,
       debian-legal@lists.debian.org, linux-kernel@vger.kernel.org,
       linux-acenic@sunsite.dk
Subject: Re: non-free firmware in kernel modules, aggregation and unclear
 copyright notice.
References: <vVUko.A.NkD.kNTVCB@murphy>
In-Reply-To: <vVUko.A.NkD.kNTVCB@murphy>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard B. Johnson wrote:

>  Well it doesn't make any difference. If GPL has degenerated to where
>  one can't upload microcode to a device as part of its initialization,
>  without having the "source" that generated that microcode, we are in
>  a lot of hurt. Intel isn't going to give their designs away.

I don't recall anyone asking Intel to give theirs designs away. This 
thread is about:

1. (mainly) some firmware hexdumps present in the kernel source tree are 
either expicitly marked as being GPL'd or unmarked, in which case one 
would assume that they would be GPL'd;

1a. this means that those firmware hexdumps are not legally 
distributable by any person besides the firmware copyright holder, 
because any other person could not comply with the terms of the Section 
3 of the GPL (IOW, a third party cannot give you a source code they 
don't have);

1b. [1a], for its turn, means that the current pristine kernel tree is 
not legally distributable and that any distributor is an easy prey for 
lawyer attacks.

2. (collaterally) some firmware hexdumps present in the kernel source 
tree are marked with "(C) Holder All Rights Reserved";

2a. copyright law FORBIDS anyone to distribute such pieces of 
information without proper authorization.

3. (corolary) for each of the problematic hexdumps, the following steps 
should be taken:

3a. the copyright holder should be asked for the source code to the 
firmware -- if they do this, it would be great for a lot of Free 
Software reasons;

3b. if the copyright holder declines, it should be asked for a license 
to freely redistribute the firmware; and

3c. if the copyright holder declines, the firmware *must* be yanked from 
the pristine kernel tree;

3d. furthermore, all of this *should* be properly documented, IMHO, both 
in a centralized file, and in the file where the firmware hexdump appears.


>  Last time I checked, GPL was about SOFTware, not FIRMware, and not
>  MICROcode. If somebody has decided to rename FIRMware to SOFTware,
>  then they need to complete the task and call it DORKware, named after
>  themselves.

Last time I checked, the GPL was a COPYRIGHT LICENSE and, as such, not 
"about" anything in particular. Yes, it was idealized to be used for the 
licensing of computer programs and libraries. OTOH, many works of many 
other kinds (music, literary works, etc) were licensed under the GPL.

>  This whole thread and gotten truly bizarre.

Nah, it has a good reason to exist... With the passing of time, Debian, 
that is supposed to be a Free Software OS, is depending more and more of 
non-Free components. And yes, as it is today, the pristine kernel tree 
is non-free.

Regards,
Massa

