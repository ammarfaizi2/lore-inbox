Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317005AbSIIKoO>; Mon, 9 Sep 2002 06:44:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317012AbSIIKoO>; Mon, 9 Sep 2002 06:44:14 -0400
Received: from gate.in-addr.de ([212.8.193.158]:36103 "HELO mx.in-addr.de")
	by vger.kernel.org with SMTP id <S317005AbSIIKoN>;
	Mon, 9 Sep 2002 06:44:13 -0400
Date: Mon, 9 Sep 2002 12:49:44 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: linux-kernel@vger.kernel.org
Subject: [RFC] Multi-path IO in 2.5/2.6 ?
Message-ID: <20020909104944.GH27887@marowsky-bree.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4i
X-Ctuhulu: HASTUR
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Morning everyone,

I hope people are waking up by now ;-)

So, what is the take on "multi-path IO" (in particular, storage) in 2.5/2.6?

Right now, we have md multipathing in 2.4 (+ an enhancement to that one by
Jens Axboe and myself, which however was ignored on l-k ;-), an enhancement to
LVM1 and various hardware-specific and thus obviously wrong approaches.

I am looking at what to do for 2.5. I have considered porting the small
changes from 2.4 to md 2.5. The LVM1 changes are probably and out gone, as
LVM1 doesn't work still.

I noticed that EVMS duplicates the entire md layer internally (great way to
code, really!), so that might also require changing if I update the md code.

Or can the LVM2 device-mapper be used to do that more cleanly?

I wonder whether anyone has given this some thought already.


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
Immortality is an adequate definition of high availability for me.
	--- Gregory F. Pfister

