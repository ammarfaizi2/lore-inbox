Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264447AbRF1V2e>; Thu, 28 Jun 2001 17:28:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264461AbRF1V2Y>; Thu, 28 Jun 2001 17:28:24 -0400
Received: from cs159246.pp.htv.fi ([213.243.159.246]:41313 "EHLO
	porkkala.cs140085.pp.htv.fi") by vger.kernel.org with ESMTP
	id <S264447AbRF1V2H>; Thu, 28 Jun 2001 17:28:07 -0400
Message-ID: <3B3BA155.98D3B636@pp.htv.fi>
Date: Fri, 29 Jun 2001 00:27:49 +0300
From: Jussi Laako <jlaako@pp.htv.fi>
X-Mailer: Mozilla 4.76 [en] (Win98; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: VIA 686B/Data Corruption
In-Reply-To: <E15FYeP-0006Yq-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A little test report follows...

Just tested RedHat's 2.4.3-12 and 2.4.5-ac19 on A7V133 mobo. RedHat's kernel
seems to work without lockups, but 2.4.5-ac19 doesn't (locks up at boot,
compiled w/o athlon optimization and ACPI), so no changes on that.

2.4.3-12 also correctly detects cable connected to VIA controller as 40-w
while 2.4.5-ac19 still detects it as 80-w.

2.4.3-12 although seems to have the reiserfs unmount lock race, so I can't
use it... :(

 - Jussi Laako

-- 
PGP key fingerprint: 161D 6FED 6A92 39E2 EB5B  39DD A4DE 63EB C216 1E4B
Available at PGP keyservers
