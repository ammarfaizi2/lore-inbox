Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261967AbTDABPl>; Mon, 31 Mar 2003 20:15:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261968AbTDABPl>; Mon, 31 Mar 2003 20:15:41 -0500
Received: from adsl-67-114-192-42.dsl.pltn13.pacbell.net ([67.114.192.42]:23070
	"EHLO mx1.corp.rackable.com") by vger.kernel.org with ESMTP
	id <S261967AbTDABPk>; Mon, 31 Mar 2003 20:15:40 -0500
Message-ID: <3E88EA79.2060301@rackable.com>
Date: Mon, 31 Mar 2003 17:25:13 -0800
From: Samuel Flory <sflory@rackable.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: gibbs@scsiguy.com
Subject: File system corruption under 2.4.21-pre5-ac1
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 01 Apr 2003 01:26:57.0186 (UTC) FILETIME=[C9082820:01C2F7ED]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   I'm seeing filesystem corruption on a number of intel SE7501wv2's 
under 2.4.21-pre5-ac1.  The systems are running Cerberus (ctcs).  They 
fail the kcompile, and memtst tests.  


   At 1st I thought it was memory, but the systems are fine under 
memtest86, and the Cerberus memtst failures disappear if I turn off my 
swap devices.  The kcompile failures seem to point to  random file 
corruption from copying the kernel tree.  (Cerberus copies a new copy of 
the kernel for each compile.)

  I suspect the aic79xx driver as:

1)I've running ctcs with the same kernel on 100+ SE7501wv2 with ide drives.
2)This occurs under reiserfs, and ext3.
3)I've been using 2.4.21-pre5-ac1 to burnin systems for quite some time.

-- 
There is no such thing as obsolete hardware.
Merely hardware that other people don't want.
(The Second Rule of Hardware Acquisition)
Sam Flory  <sflory@rackable.com>


