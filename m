Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272431AbTGZHIQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 03:08:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272433AbTGZHIQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 03:08:16 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:30429 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S272431AbTGZHIO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 03:08:14 -0400
Subject: Re: Reiser4 status: benchmarked vs. V3 (and ext3)
From: Yury Umanets <umka@namesys.com>
To: Daniel Egger <degger@fhm.edu>
Cc: Nikita Danilov <Nikita@Namesys.COM>, Hans Reiser <reiser@namesys.com>,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
       reiserfs mailing list <reiserfs-list@namesys.com>
In-Reply-To: <1059181687.10059.5.camel@sonja>
References: <3F1EF7DB.2010805@namesys.com>
	 <1059062380.29238.260.camel@sonja>
	 <16160.4704.102110.352311@laputa.namesys.com>
	 <1059093594.29239.314.camel@sonja>
	 <16161.10863.793737.229170@laputa.namesys.com>
	 <1059142851.6962.18.camel@sonja>
	 <1059143985.19594.3.camel@haron.namesys.com>
	 <1059181687.10059.5.camel@sonja>
Content-Type: text/plain
Organization: NAMESYS
Message-Id: <1059203990.21910.13.camel@haron.namesys.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 26 Jul 2003 11:19:50 +0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-07-26 at 05:08, Daniel Egger wrote:
> Am Fre, 2003-07-25 um 16.39 schrieb Yury Umanets:
> 
> > Reiser4 has plugin-based architecture. So, anybody is able to write new
> > block allocator plugin.
> 
> Cool.

> 
> > Speaking about possible embedded usage... What kind of embedded devices
> > do you mean. Reiser4 driver is big enough in size for some of them (for
> > instance, for mine MPIO MP3 player :))
> 
> I'm talking about pretty standard ix86 hardware which has embedded like
> properties such as fanless and motorless use, hardware watchdog, flash
> memory but only few of the typical limitations like restricted memory
> (we are using 256 or 512 MB), slow CPU, few connectors.


> 
> So basically we do have pretty powerful hardware with huge storage and
> memory and now need a FS which is fast and reliable even on flash
> memory. JFFS2 is nice but way too slow once one has bigger sizes.

I think this is more then enough for running reiser4. Reiser4 is a linux
filesystem first of all, and linux is able to be ran on even worse
hardware then you have.

-- 
We're flying high, we're watching the world passes by...

