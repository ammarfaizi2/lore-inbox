Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287106AbRL2DVy>; Fri, 28 Dec 2001 22:21:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287108AbRL2DVo>; Fri, 28 Dec 2001 22:21:44 -0500
Received: from svr3.applink.net ([206.50.88.3]:23570 "EHLO svr3.applink.net")
	by vger.kernel.org with ESMTP id <S287106AbRL2DV0>;
	Fri, 28 Dec 2001 22:21:26 -0500
Message-Id: <200112290321.fBT3GCSs007627@svr3.applink.net>
Content-Type: text/plain; charset=US-ASCII
From: Timothy Covell <timothy.covell@ashavan.org>
Reply-To: timothy.covell@ashavan.org
To: linux-kernel@vger.kernel.org
Subject: Fwd: Hard Lockup on 2.4.16 with Via ieee1394 (sbp2 mode)
Date: Fri, 28 Dec 2001 21:13:23 -0600
X-Mailer: KMail [version 1.3.2]
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, support@redhat.com,
        timothy.covell@ashavan.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Alan et al,

I've got a hard lockup on 2.4.16 when I insmod sbp2 for my external
FW disk drive (ADS enclosure kit).  I'm not using the official RH 2.4.9-13
RPM because the SRPM didn't build an SMP kernel and I had been
having no problems with 2.4.16ctx-4  (that's with Jacques Gelinas'
vserver patch).  Anyhow, when I built  a new kernel to support my
new Via Firewire Card (SB-FW6306-3l),  I built it with the nesc.
ieee1394 support in modules.  However:

cd /lib/modules/2.4.16-ctx4/kernel/drivers/ieee1394
insmod ieee1394
insmod ohci1394
insmod raw1394
insmod sbp2    (HARD LOCKUP)


I can rebuild again with SysRq patch if you think that'll help.  I
can also forward my kernel build ".config" file and my sysreport
to Alan if he likes. (I've already sent a ticket to support@redhat.com.
about the SMP kernel problems.)

TIA

timothy.covell@ashavan.org.
