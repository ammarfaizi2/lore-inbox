Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264960AbTFVSes (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jun 2003 14:34:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264977AbTFVSes
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jun 2003 14:34:48 -0400
Received: from ajax.cs.uga.edu ([128.192.251.3]:5297 "EHLO ajax.cs.uga.edu")
	by vger.kernel.org with ESMTP id S264960AbTFVSer (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jun 2003 14:34:47 -0400
Date: Sun, 22 Jun 2003 14:54:33 -0400
From: Ed L Cashin <ecashin@uga.edu>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Peter Braam <braam@clusterfs.com>, linux-kernel@vger.kernel.org,
       akpm@digeo.com, Alex Tomas <bzzz@tmi.comex.ru>
Subject: Re: 2.5.72 kgdb woes
Message-ID: <20030622145433.A1315@atlas.cs.uga.edu>
References: <20030622040644.GF32265@peter.cfs> <190170000.1056300719@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <190170000.1056300719@[10.10.2.4]>; from mbligh@aracnet.com on Sun, Jun 22, 2003 at 09:52:00AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 22, 2003 at 09:52:00AM -0700, Martin J. Bligh wrote:
> Where'd you get your kgdb from? -mm tree?
> 
> I have an older stub in -mjb tree, would be curious to see if that
> one works.
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/mbligh/2.5.72
> 
> or something like that.

I have been using the one in mm for a while and tried the 
one in mjb.  I didn't realize how different it was from the
kgdb in mm at the time.

It didn't work ... Man, I wish I remembered exactly what 
happened ... I think it just hung when I tried to connect 
to the remote target host.

I was connecting with the echo -e "\003" >/dev/ttyS1 method,
and I don't even know if the kgdb in mjb supports that.

-- 
--Ed L Cashin            |   PGP public key:
  ecashin@uga.edu        |   http://noserose.net/e/pgp/
