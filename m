Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129047AbQKHNKh>; Wed, 8 Nov 2000 08:10:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129455AbQKHNK0>; Wed, 8 Nov 2000 08:10:26 -0500
Received: from natmail2.webmailer.de ([192.67.198.65]:51127 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S129047AbQKHNKQ>; Wed, 8 Nov 2000 08:10:16 -0500
Message-ID: <3A0950A2.F66F1CE0@mgnet.de>
Date: Wed, 08 Nov 2000 14:09:54 +0100
From: Klaus Naumann <kernel@mgnet.de>
Organization: Mad Guys Network
X-Mailer: Mozilla 4.73 [en] (X11; I; Linux 2.4.0-test8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Userland -> Kernel communication
In-Reply-To: <Pine.LNX.4.20.0011081440360.26933-100000@marte.Deuroconsult.ro>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Catalin BOIE wrote:
> 
> Hello!
> 
> I wish to give me some pointers to how to communicate with a kernel module
> from userland.

You can use the /proc interface or a device file
(in /dev) depending on what type of comunication you need. 
These are the most common ways, not sure if there are more.

> May I use sockets?

I don't think so.

        HTH, Klaus

-- 
Klaus Naumann (mailto:kernel@mgnet.de)
http://www.mgnet.de/
Phone: ++49/8761727852
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
