Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263428AbTCNRbg>; Fri, 14 Mar 2003 12:31:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263435AbTCNRbg>; Fri, 14 Mar 2003 12:31:36 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:54411 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S263428AbTCNRbF>;
	Fri, 14 Mar 2003 12:31:05 -0500
Date: Fri, 14 Mar 2003 18:41:54 +0100
From: Jens Axboe <axboe@suse.de>
To: Joern Engel <joern@wohnheim.fh-wedel.de>
Cc: Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Top stack (l)users for 2.5.64-ac4
Message-ID: <20030314174154.GX791@suse.de>
References: <200303141509.h2EF9R017016@devserv.devel.redhat.com> <20030314172820.GH23161@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030314172820.GH23161@wohnheim.fh-wedel.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 14 2003, Joern Engel wrote:
> Hi!
> 
> 47 functions using >=1k of kernel stack on i386.
> 
> One improvement over 2.5.64, i2o_proc_* is gone. 4 down, 47 to go. :)
> 
> 0xc02063f6 presto_get_fileid:                            sub    $0x1168,%esp
> 0xc0204fc6 presto_copy_kml_tail:                         sub    $0x101c,%esp
> 0xc07b92c8 isp2x00_make_portdb:                          sub    $0xc38,%esp
> 0xc0879c05 cdromread:                                    sub    $0xa84,%esp

which function is this (cdromread)?

-- 
Jens Axboe

