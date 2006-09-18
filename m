Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751566AbWIRP0y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751566AbWIRP0y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 11:26:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751773AbWIRP0x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 11:26:53 -0400
Received: from smtp.andrew.cmu.edu ([128.2.10.81]:25543 "EHLO
	smtp.andrew.cmu.edu") by vger.kernel.org with ESMTP
	id S1751566AbWIRP0w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 11:26:52 -0400
Message-ID: <450EBABA.7040401@cmu.edu>
Date: Mon, 18 Sep 2006 11:26:50 -0400
From: George Nychis <gnychis@cmu.edu>
User-Agent: Thunderbird 1.5.0.5 (X11/20060818)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: memory suspension resume broken on thinkpad x60s
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey guys,

At one point, I had memory suspension and disk suspension working 
beautifully on my x60s with the 6 patch set from Forrest Zhao:

x60s patches # md5sum ahci-patch*
71d9cfb75eb93c441e582b345fe48d83  ahci-patch1
372d229a5ef4e89d9e96f61391f72f4d  ahci-patch2
e867b2f28e3d144fae000083d83da24d  ahci-patch3
5d16c9e54606fbd1a29966351ed32a9b  ahci-patch4
f40a8c2993d0b8cb164c224ceda4e2f9  ahci-patch5
27676e415cc928d640287c00fbad6652  ahci-patch6

So anyways, I hadn't used it in a month, after several kernel changes, 
however I have applied the patches to every kernel.

Suspend to disk works beautifully, no problems at all.

Suspend to memory seems to work, it quickly brings up the "moon" symbol 
on the x60s control board, and powers down everything else.

Then I shut the lid, and when I reopen it, it seems as though the disk 
resumes, and everything else resumes, however my screen never resumes. 
I cannot get the screen to light up at all.  I am not sure if the OS has 
completely resumed or not because I can't see anything.  However there 
is hard disk activity.

Any ideas?

Thanks!
George
