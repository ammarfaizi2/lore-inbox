Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270783AbTG0OB7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 10:01:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270796AbTG0OB7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 10:01:59 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:26318 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S270783AbTG0OBv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 10:01:51 -0400
Subject: Re: Reiser4 status: benchmarked vs. V3 (and ext3)
From: Yury Umanets <umka@namesys.com>
To: Daniel Egger <degger@fhm.edu>
Cc: Hans Reiser <reiser@namesys.com>, Nikita Danilov <Nikita@Namesys.COM>,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
       reiserfs mailing list <reiserfs-list@namesys.com>
In-Reply-To: <1059315015.10692.207.camel@sonja>
References: <3F1EF7DB.2010805@namesys.com>
	 <1059062380.29238.260.camel@sonja>
	 <16160.4704.102110.352311@laputa.namesys.com>
	 <1059093594.29239.314.camel@sonja>
	 <16161.10863.793737.229170@laputa.namesys.com>
	 <1059142851.6962.18.camel@sonja>
	 <1059143985.19594.3.camel@haron.namesys.com>
	 <1059181687.10059.5.camel@sonja>
	 <1059203990.21910.13.camel@haron.namesys.com>
	 <1059228808.10692.7.camel@sonja>  <3F23D38B.3020309@namesys.com>
	 <1059315015.10692.207.camel@sonja>
Content-Type: text/plain
Organization: NAMESYS
Message-Id: <1059315305.25361.9.camel@haron.namesys.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3.99 
Date: Sun, 27 Jul 2003 18:15:05 +0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-07-27 at 18:10, Daniel Egger wrote:
> Am Son, 2003-07-27 um 15.28 schrieb Hans Reiser:
> 
> > it is suitable for any flash device that has wear leveling built into 
> > the hardware (e.g. all compact flash cards)
> 
> Are you sure CF cards have wear leveling? I'm pretty confident that they
> have defect sector management but no wear leveling. There's a huge
> difference between those two.
> 
> > or for which a wear leveling block device driver is used (I don't know
> > if one exists for Linux).
> 
> This is normally done by the filesystem (e.g. JFFS2).

Normally device driver should be concerned about making wear out
smaller. It is up to it IMHO.

-- 
We're flying high, we're watching the world passes by...

