Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261473AbUKIKiC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261473AbUKIKiC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 05:38:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261476AbUKIKhn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 05:37:43 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:38092 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261473AbUKIKhR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 05:37:17 -0500
Subject: Re: IT8212 in 2.6.9-ac6 no raid 0 or raid 1
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Robert Toole <robert.toole@kuehne-nagel.com>
Cc: alan@lxorq.ukuu.org.uk,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <418FE1B3.8020203@kuehne-nagel.com>
References: <418FE1B3.8020203@kuehne-nagel.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1099956451.14146.4.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 09 Nov 2004 09:34:18 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2004-11-08 at 21:14, Robert Toole wrote:
> Alan, thanks for your work on the ITE8212 controllers.
> 
> Just tried your ac-6 patch for 2.6.9 on my embedded Raid controller. 
> with the controller set up in normal (No raid mode) everything is good.
> 
> When I try raid 0 or 1, I get the INVALID GEOMETRY: 0 PHYSICAL HEADS? 
> error, and the raid device is not accessible after boot.

RAID needs -ac7 which I'll post tomorrow. Bartlomiej found a bug in the
-ac7 draft code when I submitted it for 2.6.10rc merging so it slipped a
day.

Alan

