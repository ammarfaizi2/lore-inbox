Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280015AbRKXVJf>; Sat, 24 Nov 2001 16:09:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280130AbRKXVJY>; Sat, 24 Nov 2001 16:09:24 -0500
Received: from firewall.digsol.net ([63.228.1.219]:30197 "EHLO
	flanders.digsol.net") by vger.kernel.org with ESMTP
	id <S280015AbRKXVJT>; Sat, 24 Nov 2001 16:09:19 -0500
Date: Sat, 24 Nov 2001 15:09:05 -0600
From: "Marc A. Ohmann" <marc@ds6.net>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.16-pre1
Message-ID: <20011124150905.A26221@flanders.digsol.net>
In-Reply-To: <Pine.LNX.4.21.0111241636200.12066-100000@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0111241636200.12066-100000@freak.distro.conectiva>; from marcelo@conectiva.com.br on Sat, Nov 24, 2001 at 04:39:15PM -0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi,
> 
> So here it goes 2.4.16-pre1. Obviously the most important fix is the
> iput() one, which probably fixes the filesystem corruption problem people
> have been seeing.
> 
> Please, people who have been experiencing the fs corruption problems test
> this and tell me its now working so I can release a final 2.4.16 ASAP.
> 
> 
> - Correctly sync inodes in iput()			(Alexander Viro)
> - Make pagecache readahead size tunable via /proc	(was in -ac tree)
> - Fix PPC kernel compilation problems			(Paul Mackerras)

I build Andrea's patch and everything seemed to work fine.  I am building 2.4.16-pre1 on two systems right now.  What can I check to test the iput() patch or any other patches?

-- 
Marc A. Ohmann
Digital Solutions, Inc
http://ds6.net
marc@ds6.net
