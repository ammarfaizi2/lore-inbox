Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290593AbSDFBQI>; Fri, 5 Apr 2002 20:16:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313857AbSDFBPs>; Fri, 5 Apr 2002 20:15:48 -0500
Received: from nessie.weebeastie.net ([61.8.7.205]:19182 "EHLO
	theirongiant.weebeastie.net") by vger.kernel.org with ESMTP
	id <S290593AbSDFBPh>; Fri, 5 Apr 2002 20:15:37 -0500
Date: Sat, 6 Apr 2002 11:12:07 +1000
From: CaT <cat@zip.com.au>
To: Alan Cox <alan@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.19pre5-ac3
Message-ID: <20020406011206.GY550@zip.com.au>
In-Reply-To: <20020406010402.GX550@zip.com.au> <200204060109.g36199g10373@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Organisation: Furball Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 05, 2002 at 08:09:09PM -0500, Alan Cox wrote:
> > Would love to but unless I mis-grepped it is not in the patch... Wanted
> > to find out if it plays nice with ext3 now. :)
> 
> Its there ok

Including Documentation/swsusp.txt? Cos I can't see it in the patch.
Just references to it.

12 [11:11:16] root@theirongiant:/usr/src>> bzgrep -i swsusp patch-2.4.19-pre5-ac3.bz2 
+  'swsusp' or 'shutdown -z <time>' (patch for sysvinit needed). It
+  For more information take a look at Documentation/swsusp.txt.
+L:     http://lister.fornax.hu/mailman/listinfo/swsusp
+static void sysrq_handle_swsusp(int key, struct pt_regs *pt_regs,
+static struct sysrq_key_op sysrq_swsusp_op = {
+       handler:        sysrq_handle_swsusp,
+/* d */        &sysrq_swsusp_op,
+#ifndef __ASM_I386_SWSUSP_H
+#define __ASM_I386_SWSUSP_H
+#endif /* __ASM_I386_SWSUSP_H */
+#ifndef _LINUX_SWSUSP_H
+#define _LINUX_SWSUSP_H
+#endif /* _LINUX_SWSUSP_H */
+ * linux/kernel/swsusp.c
+ * For TODOs,FIXMEs also look in Documentation/swsusp.txt

-- 
SOCCER PLAYER IN GENITAL-BITING SCANDAL  ---  "It was something between
friends that I thought would have no importance until this morning when
I got up and saw all  the commotion in the news,"  Gallardo told a news
conference. "It stunned me."
Reyes told Marca that he had "felt a slight pinch."
      -- http://www.azcentral.com/offbeat/articles/1129soccer29-ON.html
