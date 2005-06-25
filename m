Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261234AbVFYSQW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261234AbVFYSQW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Jun 2005 14:16:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261242AbVFYSQW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Jun 2005 14:16:22 -0400
Received: from rproxy.gmail.com ([64.233.170.192]:21393 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261236AbVFYSQQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Jun 2005 14:16:16 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:subject:date:user-agent:to:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Py3mCdoOsLA1tJrORMQrK7FuOIgGrUOOvdl8eD2F+vYUUc1dOwWCcEenj19TTVOpOn81KVSjiuRxsschvnFJG+1EeT7Ge6ygiDZN7sj3VkuwVfsAW3DQKar6Y7aOH90zQ0siQfTmsaeUq6G36uZeyCcHPa+vT0TpfRttbOLd0fM=
From: Alexey Dobriyan <adobriyan@gmail.com>
Subject: Fwd: [Bug 4774] e1000 driver works on UP, but not SMP x86_64
Date: Sat, 25 Jun 2005 22:22:18 +0400
User-Agent: KMail/1.7.2
To: David Lang <david.lang@digitalinsight.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506252222.18681.adobriyan@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----------  Forwarded Message  ----------

Subject: [Bug 4774] e1000 driver works on UP, but not SMP x86_64
Date: Saturday 25 June 2005 21:55
From: bugme-daemon@kernel-bugs.osdl.org
To: adobriyan@gmail.com

http://bugzilla.kernel.org/show_bug.cgi?id=4774

------- Additional Comments From nacc@us.ibm.com  2005-06-25 10:55 -------
Hrm, that means that the corresponding PCI device (adapter->pdev->irq) is
requesting an IRQ greater than 224? Could you also attach the SMP .config? I
assume all you did was enabled SMP, ran make oldconfig & rebuilt? Do you know of
any kernel that *does* work?
