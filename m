Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264853AbRFTI0k>; Wed, 20 Jun 2001 04:26:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264854AbRFTI0a>; Wed, 20 Jun 2001 04:26:30 -0400
Received: from ns.suse.de ([213.95.15.193]:26117 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S264853AbRFTI0S>;
	Wed, 20 Jun 2001 04:26:18 -0400
To: Ben Greear <greearb@candelatech.com>
Cc: linux-kernel@vger.kernel.org, davem@redhat.com
Subject: Re: Should VLANs be devices or something else?
In-Reply-To: <3B2FCE0C.67715139@candelatech.com.suse.lists.linux.kernel> <Pine.LNX.4.33.0106191641150.17061-100000@duely.gurulabs.com.suse.lists.linux.kernel> <15151.55017.371775.585016@pizda.ninka.net.suse.lists.linux.kernel> <3B2FDD62.EFC6AEB1@candelatech.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 20 Jun 2001 10:26:15 +0200
In-Reply-To: Ben Greear's message of "20 Jun 2001 01:26:03 +0200"
Message-ID: <oup3d8vftg8.fsf@pigdrop.muc.suse.de>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ben Greear <greearb@candelatech.com> writes:
> 
> Adding the hashed lookup for devices took the exponential curve out of
> ip and ifconfig's performance, btw.

And fixing the ifconfig user data structures took it also.
Probably just ip needs similar tuning.
No need to add the name lookup hash table to the kernel.

Perhaps it would be best if you could post your current patch without
these hash tables, so that it can be properly reviewed and hopefully
merged then.

-Andi
