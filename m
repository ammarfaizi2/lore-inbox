Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288763AbSATPsv>; Sun, 20 Jan 2002 10:48:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288765AbSATPsc>; Sun, 20 Jan 2002 10:48:32 -0500
Received: from waldorf.cs.uni-dortmund.de ([129.217.4.42]:21383 "EHLO
	waldorf.cs.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S288763AbSATPsL>; Sun, 20 Jan 2002 10:48:11 -0500
Message-Id: <200201201548.g0KFm6kG013919@tigger.cs.uni-dortmund.de>
To: linux-kernel@vger.kernel.org
Subject: Re: rm-ing files with open file descriptors 
In-Reply-To: Message from Miquel van Smoorenburg <miquels@cistron.nl> 
   of "Sat, 19 Jan 2002 18:53:42 +0100." <20020119185342.A27582@cistron.nl> 
Date: Sun, 20 Jan 2002 16:48:06 +0100
From: Horst von Brand <brand@jupiter.cs.uni-dortmund.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miquel van Smoorenburg <miquels@cistron.nl> said:
> According to Horst von Brand:
> > > I now have a flink-test2.txt file. That is pretty cool ;)
> > 
> > This is a possible security risk: The unlinking program thinks the file is
> > forever inaccessible, but it isn't...
> 
> Why. If you keep an fd open to it it's accessible anyway, and if
> you like you can copy it to a new file. Or you could link(2) it
> beforehand, etc etc

Right. So the "staying around in /proc" is a risk.
-- 
Horst von Brand			     http://counter.li.org # 22616
