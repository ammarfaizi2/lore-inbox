Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264260AbRFOHB2>; Fri, 15 Jun 2001 03:01:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264262AbRFOHBS>; Fri, 15 Jun 2001 03:01:18 -0400
Received: from ns.suse.de ([213.95.15.193]:44049 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S264260AbRFOHBJ>;
	Fri, 15 Jun 2001 03:01:09 -0400
To: sebastien person <sebastien.person@sycomore.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: timer_list in struct net_device
In-Reply-To: <20010614154949.731a2932.sebastien.person@sycomore.fr.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 15 Jun 2001 09:01:01 +0200
In-Reply-To: sebastien person's message of "14 Jun 2001 15:52:54 +0200"
Message-ID: <oupae3akz0y.fsf@pigdrop.muc.suse.de>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sebastien person <sebastien.person@sycomore.fr> writes:

> Hi,
> 
> I want to know if the watchdog_timer found in the struct net_device can be
> used 
> as I want ?

No, it it already used by the network code to look over the driver.


-Andi
