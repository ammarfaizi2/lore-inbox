Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261225AbTILLTQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 07:19:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261237AbTILLTQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 07:19:16 -0400
Received: from pcgallir.uib.es ([130.206.79.189]:20628 "EHLO pcgallir.uib.es")
	by vger.kernel.org with ESMTP id S261225AbTILLTM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 07:19:12 -0400
From: Ricardo Galli <gallir@uib.es>
Organization: UIB
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test5: "ifconfig down" loop on wireless interface
Date: Fri, 12 Sep 2003 13:19:10 +0200
User-Agent: KMail/1.5.3
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309121319.10885.gallir@uib.es>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In my Dell laptop with a orinoco card (Dell True Mobile) ifconfig blocks 
while trying to bring down the wireless interface.  It doesn't give any 
error. ACPI is disabled, APM enabled.

It doesn't occur always, only if there was some traffic in the wireless 
interface. The process cannot be killed, but sending it kill -9 makes 
ifconfig to eat 100% of the CPU. ps axl shows the ifconfig process as 
"running", even before sending the signal. 

It's particularly annonying because the system cannot be halted properly.

-test4 doesn't suffer this problem.

Regards,

-- 
  ricardo galli       GPG id C8114D34
