Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932270AbWIVFEp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932270AbWIVFEp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 01:04:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932272AbWIVFEp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 01:04:45 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:11499 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932270AbWIVFEp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 01:04:45 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=XeFpFG9U2qhwLCnZPcid7WerH/er7lpfx8DNoK4BtFJ9x4M8fuG/eerhAYh0WJ2BL8FTmdL58iFGnEDRToAtKVDfbdhM9zARJma+DNiLJL0jYVhS7H1ZmuEBwUYg7vqtOo15cZtU+u0WfO+bn0rpZfqRgOQ5XztiDJEQxcn3bN4=
Message-ID: <489ecd0c0609212204k6cbbf63ej7d59d3855a4993e7@mail.gmail.com>
Date: Fri, 22 Sep 2006 13:04:43 +0800
From: "Luke Yang" <luke.adi@gmail.com>
To: linux-kernel@vger.kernel.org, "Andrew Morton" <akpm@osdl.org>,
       "Greg KH" <greg@kroah.com>
Subject: [PATCH 1/3] [BFIN] Blackfin architecture patch for 2.6.18
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I renewed and resend this patch.

This is the blackfin architecture for 2.6.18, again. As we promised,
we fixed some issues in our old patches as following.

- use serial core in that driver

- Fix up that ioctl so it a) doesn't sleep in spinlock and b) compiles

- Use generic IRQ framework

- Review all the volatiles, consolidate them in some helper-in-header-file.

 And we also fixed a lot of other issues and ported it to 2.6.18 now.
As usual, this architecture patch is too big so I just give a link
here. Please review it and give you comments, we really appreciate.

This is a big patch so I only put a link here:
http://blackfin.uclinux.org/frs/download.php/1010/blackfin_arch_2.6.18.patch

Signed-off-by:  Luke Yang <luke.adi@gmail.com>

-- 
Best regards,
Luke Yang
luke.adi@gmail.com
