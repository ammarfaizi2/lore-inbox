Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279974AbRJ3QGX>; Tue, 30 Oct 2001 11:06:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279971AbRJ3QGE>; Tue, 30 Oct 2001 11:06:04 -0500
Received: from pacujo.datastreet.com ([208.179.44.95]:38674 "EHLO
	lumo.pacujo.nu") by vger.kernel.org with ESMTP id <S279974AbRJ3QFu>;
	Tue, 30 Oct 2001 11:05:50 -0500
To: tcon@Physics.usyd.edu.au
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.SOL.3.96.1011030180024.12360A-100000@suphys.physics.usyd.edu.au>
	(message from Tim Connors on Tue, 30 Oct 2001 18:02:07 +1100 (EST))
Subject: Re: Need blocking /dev/null
In-Reply-To: <Pine.SOL.3.96.1011030180024.12360A-100000@suphys.physics.usyd.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20011030160446.895395693@elektro.pacujo.nu>
Date: Tue, 30 Oct 2001 08:04:46 -0800 (PST)
From: marko@pacujo.nu (Marko Rauhamaa)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> How bout just `mkfifo /tmp/blockme`
> and read on /tmp/blockme - just don't write to it!

I don't think that will work, not the same way anyway. The problem is it
will block on open(2) and will never get to read(2).


Marko

-- 
Marko Rauhamaa    mailto:marko@pacujo.nu     http://www.pacujo.nu/marko/
