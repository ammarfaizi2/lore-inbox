Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315540AbSECCpu>; Thu, 2 May 2002 22:45:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315541AbSECCpt>; Thu, 2 May 2002 22:45:49 -0400
Received: from mail-infomine.ucr.edu ([138.23.89.48]:46045 "EHLO
	mail-infomine.ucr.edu") by vger.kernel.org with ESMTP
	id <S315540AbSECCps>; Thu, 2 May 2002 22:45:48 -0400
Date: Thu, 2 May 2002 19:45:38 -0700
To: linux-kernel@vger.kernel.org
Subject: Linux 2.4.19pre8, Link Failure
Message-ID: <20020503024538.GB28504@mail-infomine.ucr.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Fnord: +++ath
X-WebTV-Stationery: Standard; BGColor=black; TextColor=black
X-Message-Flag: Message text blocked: ADULT LANGUAGE/SITUATIONS
X-BeenThere: crackmonkey@crackmonkey.org
From: ruschein@mail-infomine.ucr.edu (Johannes Ruscheinski)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On a uniprocessor compile (.config available upon request) I get the following
error:

init/main.o: In function `smp_init':
init/main.o(.text.init+0x641): undefined reference to `skip_ioapic_setup'
arch/i386/kernel/kernel.o: In function `broken_pirq':
arch/i386/kernel/kernel.o(.text.init+0x3607): undefined reference to `skip_ioapic_setup'
make: *** [vmlinux] Error 1
-- 
Johannes
--
Dr. Johannes Ruscheinski
EMail:    ruschein_AT_infomine.ucr.edu ***          Linux                  ***
Location: science library, room G40    *** The Choice Of A GNU Generation! ***
Phone:    (909) 787-2279

"He's alive.  He's alive!  Oh, that fellow at RadioShack said I was mad!
Well, who's mad now?"
                            -- Montgomery C. Burns
