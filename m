Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315211AbSDWNv1>; Tue, 23 Apr 2002 09:51:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315212AbSDWNv0>; Tue, 23 Apr 2002 09:51:26 -0400
Received: from whiskey.openminds.be ([212.35.126.198]:60611 "EHLO
	whiskey.openminds.be") by vger.kernel.org with ESMTP
	id <S315211AbSDWNvY>; Tue, 23 Apr 2002 09:51:24 -0400
Date: Tue, 23 Apr 2002 15:51:25 +0200
From: Frank Louwers <frank@openminds.be>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: linux-kernel@vger.kernel.org
Subject: Re: BUG: 2 NICs on same network
Message-ID: <20020423155125.A9208@openminds.be>
In-Reply-To: <20020423113935.A30329@openminds.be> <20020423134549.GA2048@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.21i
X-PGP2: 1024R/1A899409  C3 D8 FA D3 E0 0E 40 C5  10 32 83 74 36 F0 E5 95
X-oldGPG: 1024D/3F6A7EDD  D597 566A BDF5 BBFB C308  447A 5E81 1188 3F6A 7EDD
X-GPG: 1024D/E592712F  E857 266C 04BE 0772 B9C4  E798 3D34 D5E5 E592 712F
Organisation: Openminds - http://www.openminds.be/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> Do you really need the two interfaces to be in the same subnet ? I use
> tw parallel nets for a cluster, but configured both as independent
> subnets, 10.0.0.0 and 10.0.1.0. So you can drive all nfs through one
> interface mounting the server as 10.0.0.1, and all the bproc traffic
> through the other (or all the ssh through the other connecting
> always to 10.0.1.1).
> 
> Hope this helps.

Well, I was planning on using it as a backup link: use eth0 as my
"normal" interface card, with a traffic shaper on it, firewalled etc.

If however, something goes wrong with either the firewall, or traffic
shaper, or so, I have to drive 60 miles to my server to correct things
on the console.

I was hoping on configuring that second nic as a "backup" nic ...

Frank
