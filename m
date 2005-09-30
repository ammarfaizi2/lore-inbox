Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030289AbVI3NPW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030289AbVI3NPW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 09:15:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030295AbVI3NPW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 09:15:22 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:50895 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1030289AbVI3NPU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 09:15:20 -0400
Subject: Re: RH30: Virtual Mem shot heavily by locale-archive...
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Arijit Das <Arijit.Das@synopsys.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <7EC22963812B4F40AE780CF2F140AFE9168304@IN01WEMBX1.internal.synopsys.com>
References: <7EC22963812B4F40AE780CF2F140AFE9168304@IN01WEMBX1.internal.synopsys.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 30 Sep 2005 14:42:46 +0100
Message-Id: <1128087767.17099.5.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This seems like a huge requirement of memory for each small process executed in the RH3.0 system and hence, shots up the memory requirement of the entire system because the mapped region /usr/lib/locale/locale-archive is privately mapped.

There is no RH 3.0 for AMD64 - if you mean RHEL 3 then the mappings are
shared between processes.

