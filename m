Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135870AbRD2SK1>; Sun, 29 Apr 2001 14:10:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135871AbRD2SKV>; Sun, 29 Apr 2001 14:10:21 -0400
Received: from jalon.able.es ([212.97.163.2]:2962 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S135870AbRD2SJz>;
	Sun, 29 Apr 2001 14:09:55 -0400
Date: Sun, 29 Apr 2001 20:09:47 +0200
From: "J . A . Magallon" <jamagallon@able.es>
To: "Steve 'Denali' McKnelly" <denali@sunflower.com>
Cc: "J . A . Magallon" <jamagallon@able.es>,
        Matthias Andree <matthias.andree@stud.uni-dortmund.de>,
        Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.3 2.4.4pre8: aic7xxx showstopper bug fails to detect sda
Message-ID: <20010429200947.C1419@werewolf.able.es>
In-Reply-To: <20010429122546.A1419@werewolf.able.es> <PGEDKPCOHCLFJBPJPLNMCEDOCMAA.denali@sunflower.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <PGEDKPCOHCLFJBPJPLNMCEDOCMAA.denali@sunflower.com>; from denali@sunflower.com on Sun, Apr 29, 2001 at 18:17:14 +0200
X-Mailer: Balsa 1.1.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 04.29 Steve 'Denali' McKnelly wrote:
> Howdy J.A.,
> 
> 	Let me ask a possibly stupid question... How do you tell
> what version of the Gibbs Adaptec driver you're using?  Did I

You can look at the kernel boot messages for a line like:
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.1.12

After boot, you car look at them with 'dmesg'.

And you can also do a 'head -1 /proc/scsi/aic7xxx/*'

> misunderstand you when you said the 2.4.4 kernel is using 6.1.5?

Yes, vanilla 2.4.4 uses 6.1.5.

> Also, did I understand you to say the 6.1.12 version will fix
> my unresolved symbol problem?
> 

No, i was answering what you quoted, did not see the original message.
The 6.1.11 driver solved problems about the 'abort' messages. Dunno
about the build. I use the driver but built-in.

-- 
J.A. Magallon                                          #  Let the source
mailto:jamagallon@able.es                              #  be with you, Luke... 

Linux werewolf 2.4.4 #1 SMP Sat Apr 28 11:45:02 CEST 2001 i686

