Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310515AbSCZKzs>; Tue, 26 Mar 2002 05:55:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310864AbSCZKzi>; Tue, 26 Mar 2002 05:55:38 -0500
Received: from ns.suse.de ([213.95.15.193]:22801 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S310515AbSCZKzc>;
	Tue, 26 Mar 2002 05:55:32 -0500
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org, jgarzik@mandrakesoft.com
Subject: Re: Problems with Tigon v0.97
In-Reply-To: <ho1ye7tyqx.fsf@gee.suse.de>
	<20020326.024210.55219079.davem@redhat.com>
From: Andreas Jaeger <aj@suse.de>
Date: Tue, 26 Mar 2002 11:55:30 +0100
Message-ID: <hosn6nsin1.fsf@gee.suse.de>
User-Agent: Gnus/5.090006 (Oort Gnus v0.06) XEmacs/21.4 (Artificial
 Intelligence, i386-suse-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" <davem@redhat.com> writes:

> It's an amd756 chipset bug.  bcm5700 chooses to work around it in
> their driver, when it really belongs as a generic PCI fixup in
> the kernel.

What needs to be done for this?  Can you point me to the PCI
workaround in the bcm driver?  

I only found via grep in the sources a workaround for the AMD 762
northbridge but nothing directly for the 756.

Thanks,
Andreas
-- 
 Andreas Jaeger
  SuSE Labs aj@suse.de
   private aj@arthur.inka.de
    http://www.suse.de/~aj
