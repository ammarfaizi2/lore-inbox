Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129257AbQLNXPW>; Thu, 14 Dec 2000 18:15:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129773AbQLNXPN>; Thu, 14 Dec 2000 18:15:13 -0500
Received: from pop.gmx.net ([194.221.183.20]:46416 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S129260AbQLNXPA>;
	Thu, 14 Dec 2000 18:15:00 -0500
From: Norbert Breun <nbreun@gmx.de>
Reply-To: nbreun@gmx.de
Organization: private
Date: Thu, 14 Dec 2000 23:41:54 +0100
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Subject: "No rule to make target `irlan/irlan.o " in 2.4.0-test12pre1
MIME-Version: 1.0
Message-Id: <00121423412500.08962@nmb>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo,

compiling a fresh patched 2.4.0.13pre1 and make modules shows me following 
error:

make[2]: *** No rule to make target `irlan/irlan.o', needed by `modules'.  
Stop.make[2]: Leaving directory `/usr/src/linux-2.4.0.13pre1/net/irda'
make[1]: *** [_modsubdir_irda] Error 2
make[1]: Leaving directory `/usr/src/linux-2.4.0.13pre1/net'
make: *** [_mod_net] Error 2

make modules_install shows:

depmod: *** Unresolved symbols in 
/lib/modules/2.4.0-test12/kernel/fs/nfs/nfs.o
depmod:         lockd_up_Rsmp_f6933c48
depmod:         nlmclnt_proc_Rsmp_0f4e5e85
depmod:         lockd_down_Rsmp_a7b91a7b
depmod: *** Unresolved symbols in 
/lib/modules/2.4.0-test12/kernel/fs/nfsd/nfsd.o
depmod:         lockd_up_Rsmp_f6933c48
depmod:         nlmsvc_ops_Rsmp_d56c4cfc
depmod:         nlmsvc_invalidate_client_Rsmp_b1c3f825
depmod:         lockd_down_Rsmp_a7b91a7b

using 2.4.0.12 seems o.K. to me (installed a patch for 8139.too manually.)

kind regards

Norbert
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
