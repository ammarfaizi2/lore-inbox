Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282964AbRK0VLi>; Tue, 27 Nov 2001 16:11:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282959AbRK0VL2>; Tue, 27 Nov 2001 16:11:28 -0500
Received: from ns.suse.de ([213.95.15.193]:26374 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S282957AbRK0VLS>;
	Tue, 27 Nov 2001 16:11:18 -0500
To: andrew@pimlott.ne.mediaone.net (Andrew Pimlott)
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.16: "Address family not supported" on RH IBM T23
In-Reply-To: <20011127200522.B27480@indexdata.dk.suse.lists.linux.kernel> <m168nl3-000OVrC@amadeus.home.nl.suse.lists.linux.kernel> <20011127153119.A25554@pimlott.ne.mediaone.net.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 27 Nov 2001 22:11:14 +0100
In-Reply-To: andrew@pimlott.ne.mediaone.net's message of "27 Nov 2001 21:47:38 +0100"
Message-ID: <p73elmjsyvh.fsf@amdsim2.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

andrew@pimlott.ne.mediaone.net (Andrew Pimlott) writes:
> 
> And is CONFIG_RTNETLINK also necessary for ip?

In vger (networking development tree) these options have just been removed
and hardcoded to on. 
It'll likely show up soon in the main tree soon.

If that were not the case it would be better to fix iproute2 to give a
more meaningfull error message.

-Andi

