Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317214AbSHGNHn>; Wed, 7 Aug 2002 09:07:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317141AbSHGNGi>; Wed, 7 Aug 2002 09:06:38 -0400
Received: from zeus.kernel.org ([204.152.189.113]:47243 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S317214AbSHGNGd>;
	Wed, 7 Aug 2002 09:06:33 -0400
Date: Wed, 7 Aug 2002 14:28:50 +0200
From: Stephane Wirtel <stephane.wirtel@belgacom.net>
To: Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: compile error 2-4.20-pre1-ac1 -- AIC7xxx
Message-Id: <20020807142850.3a7a091b.stephane.wirtel@belgacom.net>
X-Mailer: Sylpheed version 0.8.1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

here is a compile error with 2.4.20-pre1-ac1

<M> Adaptec AIC7xxx support  

CONFIG_SCSI_AIC7XXX=m
CONFIG_AIC7XXX_CMDS_PER_DEVICE=253
CONFIG_AIC7XXX_RESET_DELAY_MS=15000
CONFIG_AIC7XXX_PROBE_EISA_VL=y
CONFIG_AIC7XXX_BUILD_FIRMWARE=y
CONFIG_SCSI_AIC7XXX_OLD=m
CONFIG_AIC7XXX_OLD_TCQ_ON_BY_DEFAULT=y
CONFIG_AIC7XXX_OLD_CMDS_PER_DEVICE=8
CONFIG_AIC7XXX_OLD_PROC_STATS=y

certainly an error with the previous driver of this scsi card

make[3]: Entering directory `/root/linux-2.4.20-pre1-ac1/drivers/scsi/aic7xxx'
make -C aicasm
make[4]: Entering directory `/root/linux-2.4.20-pre1-ac1/drivers/scsi/aic7xxx/aicasm'
yacc -d -b aicasm_gram aicasm_gram.y
make[4]: yacc: Command not found
make[4]: *** [aicasm_gram.h] Error 127
make[4]: Leaving directory `/root/linux-2.4.20-pre1-ac1/drivers/scsi/aic7xxx/aicasm'
make[3]: *** [aicasm/aicasm] Error 2
make[3]: Leaving directory `/root/linux-2.4.20-pre1-ac1/drivers/scsi/aic7xxx'
make[2]: *** [_modsubdir_aic7xxx] Error 2
make[2]: Leaving directory `/root/linux-2.4.20-pre1-ac1/drivers/scsi'
make[1]: *** [_modsubdir_scsi] Error 2
make[1]: Leaving directory `/root/linux-2.4.20-pre1-ac1/drivers'
make: *** [_mod_drivers] Error 2
bash-2.05a# 


Stéphane Wirtel
