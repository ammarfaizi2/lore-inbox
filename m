Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751211AbWIIAOZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751211AbWIIAOZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 20:14:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751220AbWIIAOZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 20:14:25 -0400
Received: from mx1.redhat.com ([66.187.233.31]:31980 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751211AbWIIAOW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 20:14:22 -0400
Date: Fri, 8 Sep 2006 20:19:25 -0400
From: Dave Jones <davej@redhat.com>
To: Greg KH <gregkh@suse.de>
Cc: linux-kernel@vger.kernel.org, stable@kernel.org,
       Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, Adrian Bunk <bunk@stusta.de>
Subject: Fwd: [-stable patch] pci_ids.h: add some VIA IDE identifiers
Message-ID: <20060909001925.GB1032@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, Greg KH <gregkh@suse.de>,
	linux-kernel@vger.kernel.org, stable@kernel.org,
	Justin Forbes <jmforbes@linuxtx.org>,
	Zwane Mwaikambo <zwane@arm.linux.org.uk>,
	Theodore Ts'o <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
	Chuck Wolber <chuckw@quantumlinux.com>,
	Chris Wedgwood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
	akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
	Adrian Bunk <bunk@stusta.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="17pEHd4RhPHOinZp"
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--17pEHd4RhPHOinZp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This never made it into 2.6.17.12
Without it, this happens..

drivers/ide/pci/via82cxxx.c:85: error: 'PCI_DEVICE_ID_VIA_8237A' undeclared here (not in a function)

	Dave

--17pEHd4RhPHOinZp
Content-Type: message/rfc822
Content-Disposition: inline

Return-Path: <bunk@stusta.de>
X-Spam-Checker-Version: SpamAssassin 3.1.4 (2006-07-25) on 
	pressure.kernelslacker.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=5.0 tests=AWL,BAYES_00,
	UNPARSEABLE_RELAY,UPPERCASE_25_50 autolearn=ham version=3.1.4
Received: from pobox.devel.redhat.com [10.11.255.8]
	by pressure.kernelslacker.org with IMAP (fetchmail-6.3.4)
	for <davej@localhost> (single-drop); Wed, 06 Sep 2006 19:40:41 -0400 (EDT)
Received: from pobox.devel.redhat.com ([unix socket])
	 by pobox.devel.redhat.com (Cyrus v2.2.12-Invoca-RPM-2.2.12-3.RHEL4.1) with LMTPA;
	 Wed, 06 Sep 2006 19:33:13 -0400
X-Sieve: CMU Sieve 2.2
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by pobox.devel.redhat.com (8.13.1/8.13.1) with ESMTP id k86NXDZ0000483
	for <davej@pobox.devel.redhat.com>; Wed, 6 Sep 2006 19:33:13 -0400
Received: from mx1.redhat.com (mx1.redhat.com [172.16.48.31])
	by int-mx1.corp.redhat.com (8.12.11.20060308/8.12.11) with ESMTP id k86NXDOn002640
	for <davej@redhat.com>; Wed, 6 Sep 2006 19:33:13 -0400
Received: from mailout.stusta.mhn.de (mailout.stusta.mhn.de [141.84.69.5])
	by mx1.redhat.com (8.12.11.20060308/8.12.11) with SMTP id k86NXBur012012
	for <davej@redhat.com>; Wed, 6 Sep 2006 19:33:12 -0400
Received: (qmail 5376 invoked from network); 6 Sep 2006 23:33:04 -0000
Received: from r063144.stusta.swh.mhn.de (10.150.63.144)
  by mailhub.stusta.mhn.de with SMTP; 6 Sep 2006 23:33:04 -0000
Received: by r063144.stusta.swh.mhn.de (Postfix, from userid 1000)
	id E3C18114290; Thu,  7 Sep 2006 01:33:03 +0200 (CEST)
Date: Thu, 7 Sep 2006 01:33:03 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Greg KH <gregkh@suse.de>
Cc: linux-kernel@vger.kernel.org, stable@kernel.org,
        Justin Forbes <jmforbes@linuxtx.org>,
        Zwane Mwaikambo <zwane@arm.linux.org.uk>,
        "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
        Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
        Chris Wedgwood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
        akpm@osdl.org, alan@lxorguk.ukuu.org.uk
Subject: [-stable patch] pci_ids.h: add some VIA IDE identifiers
Message-ID: <20060906233303.GA25473@stusta.de>
References: <20060906224631.999046890@quad.kroah.org> <20060906225736.GC15922@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060906225736.GC15922@kroah.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RedHat-Spam-Score: 0.261 

On Wed, Sep 06, 2006 at 03:57:36PM -0700, Greg KH wrote:
> -stable review patch.  If anyone has any objections, please let us know.
> 
> ------------------
> From: Alan Cox <alan@lxorguk.ukuu.org.uk>
> 
> 
> The following change from -mm is important to 2.6.18 (actually to 2.6.17
> but its too late for that). This was contributed over three months ago
> by VIA to Bartlomiej and nothing happened. As a result the new chipset
> is now out and Linux won't run on it. By the time 2.6.18 is finalised
> this will be the defacto standard VIA chipset so support would be a good
> plan.
> 
> Tested in -mm for a while, its essentially a PCI ident update but for
> the bridge chip because VIA do things in weird ways.
> 
> 
> Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
> 
> 
> ---
>  drivers/ide/pci/via82cxxx.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>...

If anyone actually tries to compile this driver the patch below might 
be helpful.

cu
Adrian


<--  snip  -->


commit 47251e05f74783cc03f83f5e88016fc2cbd059f1
Author: Alan Cox <alan@redhat.com>
Date:   Wed Sep 6 19:55:17 2006 +0200

    pci_ids.h: add some VIA IDE identifiers
    
    Signed-off-by: Alan Cox <alan@redhat.com>
    Signed-off-by: Adrian Bunk <bunk@stusta.de>

diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 751eea5..960fb7b 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -1223,6 +1223,7 @@ #define PCI_DEVICE_ID_VIA_PT880		0x0258
 #define PCI_DEVICE_ID_VIA_PX8X0_0	0x0259
 #define PCI_DEVICE_ID_VIA_3269_0	0x0269
 #define PCI_DEVICE_ID_VIA_K8T800PRO_0	0x0282
+#define PCI_DEVICE_ID_VIA_3296_0	0x0296
 #define PCI_DEVICE_ID_VIA_8363_0	0x0305
 #define PCI_DEVICE_ID_VIA_P4M800CE	0x0314
 #define PCI_DEVICE_ID_VIA_8371_0	0x0391
@@ -1230,6 +1231,7 @@ #define PCI_DEVICE_ID_VIA_8501_0	0x0501
 #define PCI_DEVICE_ID_VIA_82C561	0x0561
 #define PCI_DEVICE_ID_VIA_82C586_1	0x0571
 #define PCI_DEVICE_ID_VIA_82C576	0x0576
+#define PCI_DEVICE_ID_VIA_SATA_EIDE	0x0581
 #define PCI_DEVICE_ID_VIA_82C586_0	0x0586
 #define PCI_DEVICE_ID_VIA_82C596	0x0596
 #define PCI_DEVICE_ID_VIA_82C597_0	0x0597
@@ -1270,10 +1272,11 @@ #define PCI_DEVICE_ID_VIA_8378_0	0x3205
 #define PCI_DEVICE_ID_VIA_8783_0	0x3208
 #define PCI_DEVICE_ID_VIA_8237		0x3227
 #define PCI_DEVICE_ID_VIA_8251		0x3287
-#define PCI_DEVICE_ID_VIA_3296_0	0x0296
+#define PCI_DEVICE_ID_VIA_8237A		0x3337
 #define PCI_DEVICE_ID_VIA_8231		0x8231
 #define PCI_DEVICE_ID_VIA_8231_4	0x8235
 #define PCI_DEVICE_ID_VIA_8365_1	0x8305
+#define PCI_DEVICE_ID_VIA_CX700		0x8324
 #define PCI_DEVICE_ID_VIA_8371_1	0x8391
 #define PCI_DEVICE_ID_VIA_82C598_1	0x8598
 #define PCI_DEVICE_ID_VIA_838X_1	0xB188

--17pEHd4RhPHOinZp--
