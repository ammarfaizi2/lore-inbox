Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263815AbUHCIVM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263815AbUHCIVM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 04:21:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264512AbUHCIVM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 04:21:12 -0400
Received: from adsl-68-95-0-242.dsl.rcsntx.swbell.net ([68.95.0.242]:58241
	"EHLO arion.soze.net") by vger.kernel.org with ESMTP
	id S263815AbUHCIVL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 04:21:11 -0400
Date: Tue, 3 Aug 2004 08:21:00 +0000
From: Justin Guyett <justin@soze.net>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Hibbard.Smith@nasdaq.com
Subject: Re: 2.6 mainline i2o issues with adaptec raid
Message-ID: <20040803082100.GA2818@arion.soze.net>
References: <20040803050223.GB2295@arion.soze.net> <20040802230931.04c0769d.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040802230931.04c0769d.akpm@osdl.org>
X-PGP-Fingerprint: 9AE2 9FC3 D98B 9AE2 EE83  15CC 9C7D 1925 4568 5243
X-Hashcash: 0:040803:akpm@osdl.org:8c3078ed707dc95bf8cda216
X-Hashcash: 0:040803:linux-kernel@vger.kernel.org:adb1dbc347d225785501e1d8
X-Hashcash: 0:040803:hibbard.smith@nasdaq.com:c2c945d3b8296a564469669a
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2004-08-02T23:09:31-0700, Andrew Morton wrote:
> Justin Guyett <justin-lkml@soze.net> wrote:
> >
> >  I just started toying with an adaptec i2o card, an Adaptec 2110s, and
> >  for random reads and writes bonnie++ shows that the i2o driver is
> >  somewhat slower than the dpt_i2o driver.
> 
> By reading your .config I was able to divine that you're running some 2.6
> kernel ;)

I knew I forgot something.

> There's an i2o rewrite in
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.8-rc2/2.6.8-rc2-mm2/2.6.8-rc2-mm2.gz
> - testing of that would be appreciated.

Upon booting 2.6.8-rc2-mm:

 devfs_mk_dir: invalid argument.<6> i2o/hda: i2o/hda1 i2o/hda2 i2o/hda3
i2o/hda4 < i2o/hda5 i2o/hda6 i2o/hda7 i2o/hda8 >

