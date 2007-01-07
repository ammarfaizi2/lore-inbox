Return-Path: <linux-kernel-owner+w=401wt.eu-S932462AbXAGJyV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932462AbXAGJyV (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 04:54:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932463AbXAGJyV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 04:54:21 -0500
Received: from pxy2nd.nifty.com ([202.248.175.14]:27316 "HELO pxy2nd.nifty.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932462AbXAGJyU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 04:54:20 -0500
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Sun, 07 Jan 2007 04:54:20 EST
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=pxy2nd-default; d=mbf.nifty.com;
  b=EV22a/E2Pss7Dw/z85uFfdFEQbU7oj2qnO6KsL++lhmHEiRXw1UopfReSHTkIAURzd/lNnasUM3Fm3ALKL0INw==  ;
From: TAKADA <takada@mbf.nifty.com>
To: linux-kernel@vger.kernel.org
Subject: i386,2.6 cyrix.c cann't found companion chip
X-Mailer-Plugin: BkASPil for Becky!2 Ver.2.064
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.28.01 [ja]
Message-ID: <20070107094738.21919.qmail@smb516.nifty.com>
Date: Sun, 7 Jan 2007 18:47:38 +0900
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi. I use MediaGX with kernel 2.6.19.
cirix.c try to find companion chip (CS5510 and CS5520) with
pci_devPresent().
However, cyrix.c cannot find a companion chip because a list of
pci_devices is not yet initialized when __cpuinit is called.
Therefore, Search functions such as the 2.4 kernel which pci_devices
list is needless is necessary.

How will it be good?

-- 
TAKADA <takada@mbf.nifty.com>


