Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284008AbRLEKcK>; Wed, 5 Dec 2001 05:32:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284009AbRLEKcB>; Wed, 5 Dec 2001 05:32:01 -0500
Received: from ns.suse.de ([213.95.15.193]:28421 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S284008AbRLEKb5>;
	Wed, 5 Dec 2001 05:31:57 -0500
To: "Jyotheeswara Rao Kurma" <jyotheeswara.rao@wipro.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: netlink socket help
In-Reply-To: <36e2a38f71.38f7136e2a@wipro.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 05 Dec 2001 11:31:56 +0100
In-Reply-To: "Jyotheeswara Rao Kurma"'s message of "5 Dec 2001 07:11:35 +0100"
Message-ID: <p73r8qa7yar.fsf@amdsim2.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Jyotheeswara Rao Kurma" <jyotheeswara.rao@wipro.com> writes:


> How to get kernel route table ( not cache ) into user space , using
> netlink sockets, i tried with NLM_F_ROOT option. but it is giving the 
> route cache . 

Don't set the RTM_F_CLONED flag in the request.

-Andi
