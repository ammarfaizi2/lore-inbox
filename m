Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280019AbRJ3Qnz>; Tue, 30 Oct 2001 11:43:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280021AbRJ3Qnq>; Tue, 30 Oct 2001 11:43:46 -0500
Received: from shed.alex.org.uk ([195.224.53.219]:9875 "HELO shed.alex.org.uk")
	by vger.kernel.org with SMTP id <S280015AbRJ3Qnl>;
	Tue, 30 Oct 2001 11:43:41 -0500
Date: Tue, 30 Oct 2001 16:44:18 -0000
From: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Reply-To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
To: arjan@fenrus.demon.nl, Sam Vilain <sam@vilain.net>
Cc: linux-kernel@vger.kernel.org,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Subject: Re: eepro100 quirk with APM suspend on Dell laptops
Message-ID: <13270000.1004460258@shed>
In-Reply-To: <E15yTkh-0001hc-00@fenrus.demon.nl>
In-Reply-To: <E15yTkh-0001hc-00@fenrus.demon.nl>
X-Mailer: Mulberry/2.1.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan,

> For the Red Hat Linux kernel we added a quirk for this machine that
> restores PCI config space on restore, so that this is no longer needed.
> It's kind of a hack so I haven't sent it to Linus for merging yet....

Is this the 'resume=force' stuff, by any chance? (driver/pci/bridge.c
et al.)?

I am trying to port this (only) to 2.4.12-ac5 or later, as I think
the lack of this may be why resume dies on the T23. If you have
a ready-made diff containing this, I would be very grateful
& will try here, & report back.

--
Alex Bligh
