Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265184AbSKJVkE>; Sun, 10 Nov 2002 16:40:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265185AbSKJVkE>; Sun, 10 Nov 2002 16:40:04 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:32929 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S265184AbSKJVkE>; Sun, 10 Nov 2002 16:40:04 -0500
Subject: Re: Voyager subarchitecture for 2.5.46
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Lars Marowsky-Bree <lmb@suse.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021110201645.GI835@marowsky-bree.de>
References: <20021110191822.GA1237@elf.ucw.cz>
	<Pine.LNX.4.44.0211101127460.9581-100000@home.transmeta.com>
	<20021110194204.GF3068@atrey.karlin.mff.cuni.cz>
	<6usmy99osn.fsf@zork.zork.net>  <20021110201645.GI835@marowsky-bree.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 10 Nov 2002 22:11:12 +0000
Message-Id: <1036966272.1099.26.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-11-10 at 20:16, Lars Marowsky-Bree wrote:
> Processes expecting time to increase strictly monotonically across process
> boundaries will enjoy life in cluster settings or when the admin adjusts the
> time.

I'd fix your cluster code. OpenMosix gets this right and clusters
outside the mosix/numa/ssi world don't generally care as you are
restarting services, but even then tend to use NTP to keep a bendy but
forwarding moving time.

Alan

