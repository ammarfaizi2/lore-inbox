Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750725AbWF2M1q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750725AbWF2M1q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 08:27:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751375AbWF2M1q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 08:27:46 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:40525 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750725AbWF2M1p convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 08:27:45 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:to:subject:message-id:mime-version:content-type:content-disposition:x-operating-system:user-agent:content-transfer-encoding:from;
        b=FfG16GLoLpAoEh7iuiVGXU5A3h4+UaHJjIXRwPua2nnr50P3H/Eau/0nOT2bhfEEcw5uk0Tk0rGpGbXAxl1AlDQSEy2Ln7bwaoI951qCdtVdGNR4oE2CLMfn0IdGDNo4d/lwjpuTDIQTKRdBbdBuFqy4sX5AHuZF2JnldR+QwzU=
Date: Thu, 29 Jun 2006 14:27:22 +0200
To: linux-kernel@vger.kernel.org
Subject: 2.6.17-mm4 undefined reference to `alternatives_smp_module_del'
Message-ID: <20060629122721.GA18671@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
X-Operating-System: Linux 2.6.17-mm4
User-Agent: Mutt/1.5.11
Content-Transfer-Encoding: 8BIT
From: Gregoire Favre <gregoire.favre@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

just tried to compil 2.6.17-mm4 under amd64 and it fails with :

  AR      arch/x86_64/lib/lib.a
  GEN     .version
  CHK     include/linux/compile.h
  UPD     include/linux/compile.h
  CC      init/version.o
  LD      init/built-in.o
  LD      .tmp_vmlinux1
arch/x86_64/kernel/built-in.o: In function `module_arch_cleanup':
(.text.module_arch_cleanup+0x1): undefined reference to `alternatives_smp_module_del'
arch/x86_64/kernel/built-in.o: In function `module_finalize':
(.text.module_finalize+0xe8): undefined reference to `alternatives_smp_module_add'
make: *** [.tmp_vmlinux1] Error 1


Please CC to me if some more info are needed as I am not on this list.
-- 
Grégoire FAVRE  http://gregoire.favre.googlepages.com  http://www.gnupg.org
