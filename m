Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262828AbRE0RVj>; Sun, 27 May 2001 13:21:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262831AbRE0RVb>; Sun, 27 May 2001 13:21:31 -0400
Received: from twilight.cs.hut.fi ([130.233.40.5]:6201 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S262828AbRE0RVZ>; Sun, 27 May 2001 13:21:25 -0400
Date: Sun, 27 May 2001 20:21:19 +0300
From: Ville Herva <vherva@mail.niksula.cs.hut.fi>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: cesar.da.silva@cyberdude.com, kernellist <linux-kernel@vger.kernel.org>
Subject: Re: Please help me fill in the blanks.
Message-ID: <20010527202119.I11981@niksula.cs.hut.fi>
In-Reply-To: <20010527021808.80979.qmail@web13407.mail.yahoo.com> <3B1065FD.3F8D7EDF@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3B1065FD.3F8D7EDF@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Sat, May 26, 2001 at 10:27:09PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > * Dynamic Memory Resilience
> 
> RAM fault tolerance?  There was a patch a long time ago which detected
> bad ram, and would mark those memory clusters as unuseable at boot. 
> However that is clearly not dynamic.

If you are referring to Badram patch by Rick van Rein
(http://rick.vanrein.org/linux/badram/), it doesn't detect the bad ram,
memtest86 does that part (and does it well) -- you enter then enter the
badram clusters as boot param. But I have to say badram patch works
marvellously (thanks, Rick.) Shame it didn't find its way to standard
kernel.

 
-- v --

v@iki.fi
