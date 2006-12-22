Return-Path: <linux-kernel-owner+w=401wt.eu-S1423039AbWLVOee@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423039AbWLVOee (ORCPT <rfc822;w@1wt.eu>);
	Fri, 22 Dec 2006 09:34:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423074AbWLVOee
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Dec 2006 09:34:34 -0500
Received: from www17.your-server.de ([213.133.104.17]:3046 "EHLO
	www17.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423039AbWLVOed (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Dec 2006 09:34:33 -0500
X-Greylist: delayed 510 seconds by postgrey-1.27 at vger.kernel.org; Fri, 22 Dec 2006 09:34:33 EST
Message-ID: <458BECA8.2080807@m3y3r.de>
Date: Fri, 22 Dec 2006 15:33:12 +0100
From: Thomas Meyer <thomas@m3y3r.de>
User-Agent: Thunderbird 1.5.0.8 (X11/20061126)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: WARNING: Absolute relocations present
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: thomas@m3y3r.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

More warnings on current git head:

  OBJCOPY arch/i386/boot/compressed/vmlinux.bin
  RELOCS  arch/i386/boot/compressed/vmlinux.relocs
WARNING: Absolute relocations present
Offset     Info     Type     Sym.Value Sym.Name
c0107bd7 00636601   R_386_32 c034f000  __smp_alt_instructions
c0107bff 00622301   R_386_32 c034f000  __smp_alt_instructions_end
c0107c68 00622301   R_386_32 c034f000  __smp_alt_instructions_end
c0107c6d 00636601   R_386_32 c034f000  __smp_alt_instructions
c01365aa 004aba01   R_386_32 c030ef3c  __stop___ksymtab_gpl_future
c01365af 0053a101   R_386_32 c030ef3c  __start___ksymtab_gpl_future
c01365e6 0053a101   R_386_32 c030ef3c  __start___ksymtab_gpl_future
c01365ed 004aad01   R_386_32 c0311d38  __start___kcrctab_gpl_future
c01365f4 00486d01   R_386_32 c030ef3c  __stop___ksymtab_unused
c01365f9 004b6601   R_386_32 c030ef3c  __start___ksymtab_unused
c0136614 004b6601   R_386_32 c030ef3c  __start___ksymtab_unused
c013661b 004c4d01   R_386_32 c0311d38  __start___kcrctab_unused
and so on...

Should i ignore these warnings, too?

I have to ignore a lot of warnings on the current linux tree...


