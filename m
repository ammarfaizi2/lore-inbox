Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272127AbTGYO2H (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 10:28:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272128AbTGYO2G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 10:28:06 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:33470 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S272127AbTGYO17
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 10:27:59 -0400
Subject: Re: Reiser4 status: benchmarked vs. V3 (and ext3)
From: Yury Umanets <umka@namesys.com>
To: Daniel Egger <degger@fhm.edu>
Cc: Nikita Danilov <Nikita@Namesys.COM>, Hans Reiser <reiser@namesys.com>,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
       reiserfs mailing list <reiserfs-list@namesys.com>
In-Reply-To: <1059142851.6962.18.camel@sonja>
References: <3F1EF7DB.2010805@namesys.com>
	 <1059062380.29238.260.camel@sonja>
	 <16160.4704.102110.352311@laputa.namesys.com>
	 <1059093594.29239.314.camel@sonja>
	 <16161.10863.793737.229170@laputa.namesys.com>
	 <1059142851.6962.18.camel@sonja>
Content-Type: text/plain
Organization: NAMESYS
Message-Id: <1059143985.19594.3.camel@haron.namesys.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 25 Jul 2003 18:39:45 +0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-07-25 at 18:20, Daniel Egger wrote:
> Am Fre, 2003-07-25 um 15.02 schrieb Nikita Danilov:
> 
> > No special measures are taken to level block allocation. Wandered blocks
> > are allocated to improve packing i.e., place blocks of the same file
> > close to each other. Actually, it tries to place tree nodes in the
> > parent-first order.

> 
> So the new blocks are created as close as possible to the old blocks
> instead of say spreading them as far as possible. This is pretty bad for
> usage in the embedded world but I guess this is not the market you're
> aiming at. :(

Reiser4 has plugin-based architecture. So, anybody is able to write new
block allocator plugin.


Speaking about possible embedded usage... What kind of embedded devices
do you mean. Reiser4 driver is big enough in size for some of them (for
instance, for mine MPIO MP3 player :))
-- 
We're flying high, we're watching the world passes by...

