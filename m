Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751317AbWDNXN7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751317AbWDNXN7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Apr 2006 19:13:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751441AbWDNXN7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Apr 2006 19:13:59 -0400
Received: from main.gmane.org ([80.91.229.2]:8898 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751317AbWDNXN7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Apr 2006 19:13:59 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Orion Poplawski <orion@cora.nwra.com>
Subject: Problems (lockup/hang) with PCI-X slot on X5DPL motherboard
Date: Fri, 14 Apr 2006 17:13:38 -0600
Message-ID: <e1pab8$22t$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: inferno.cora.nwra.com
User-Agent: Thunderbird 1.5 (X11/20060313)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm getting to my wits end, so any help would be greatly appreciated.

I've got two disk servers, on with SuperMicro X5DPL-iGM motherboard, the 
other with a X5DPL-TGM board.  These system use the E7501 chipset, and 
provide to PCI-X buses.  One for slots 4 and 5, the other for slot 6 and 
the embedded Intel 82545EM GigE NIC.

I have had nothing but trouble trying to use slot 6 on these machines. 
Recently I've been trying with a MV88SX6081 133MHz PCI-X card.  In both 
machines I get lockups when trying to use the controller.  I also see 
corruption on the on-board NIC on the TGM (though not on the iGM) with 
the card in slot 6.

I'm running Fedora Core 4 with kernel 2.6.12-1.1456_FC4smp and mv_sata 
driver 3.6.1.  I'm stuck on the older kernel because of the mv_sata driver.

Now, maybe this is all the fault of the mv_sata driver, but I believe I 
had problems on the iGM machine with a Intel 82545GM PCI-X nic in slot 6 
as well which does not use the mv_sata driver at all normally.

Thoughts?

- Orion

-- 
Orion Poplawski
System Administrator                   303-415-9701 x222
Colorado Research Associates/NWRA      FAX: 303-415-9702
3380 Mitchell Lane, Boulder CO 80301   http://www.co-ra.com

