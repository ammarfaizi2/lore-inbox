Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269853AbRHDSrg>; Sat, 4 Aug 2001 14:47:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269854AbRHDSr1>; Sat, 4 Aug 2001 14:47:27 -0400
Received: from nef.ens.fr ([129.199.96.32]:31498 "EHLO nef.ens.fr")
	by vger.kernel.org with ESMTP id <S269853AbRHDSrU>;
	Sat, 4 Aug 2001 14:47:20 -0400
Date: Sat, 4 Aug 2001 20:47:15 +0200
From: Thomas Pornin <Thomas.Pornin@ens.fr>
To: jamagallon@able.es
Cc: linux-kernel@vger.kernel.org
Subject: Re: fake loop
Message-ID: <20010804204714.A46137@bolet.ens.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010804021304.A21339@werewolf.able.es>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20010804021304.A21339@werewolf.able.es> you write:
> I have heard many times that kernel is not thought to be compiled by
> anything but gcc. Please, start useing gcc features

-- There is little point in using gcc-specific features when there is
a completely standard idiom that does the job just as well. Unless your
goal is to obliterate all potential hopes to compile the kernel with
another compiler at some time in the future.

-- I heard that the gcc people are not especially happy with that
feature anyway, and they will maintain it only for compatibility;
which means any potential optimisation will rather go into the
standard construct (the do...while(0)) rather than the gcc-ism.


	--Thomas Pornin
