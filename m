Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290338AbSBYLPf>; Mon, 25 Feb 2002 06:15:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291743AbSBYLP0>; Mon, 25 Feb 2002 06:15:26 -0500
Received: from swazi.realnet.co.sz ([196.28.7.2]:52419 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S290338AbSBYLPS>; Mon, 25 Feb 2002 06:15:18 -0500
Date: Mon, 25 Feb 2002 13:03:20 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: Helge Hafting <helgehaf@aitel.hist.no>
Cc: David Burrows <snadge@ugh.net.au>, <linux-kernel@vger.kernel.org>
Subject: Re: Dodgey Linus BogoMIPS code ;) (was Re: baffling linux bug)
In-Reply-To: <3C7A073D.90A33D03@aitel.hist.no>
Message-ID: <Pine.LNX.4.44.0202251259380.8317-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Feb 2002, Helge Hafting wrote:

> Maybe you can get the machine to boot by skipping the bogomips
> calculation completely - by hardcoding the value your machine used to 
> come up with?
> Not for production use - just to get a debugging kernel going.

One thing worth keeping in mind also is that Linux makes assumptions about 
the i8254 timer interval, try booting verbose in FreeBSD and try and 
see what you get.

	Zwane


