Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264276AbTDPJmN (for <rfc822;willy@w.ods.org>); Wed, 16 Apr 2003 05:42:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264277AbTDPJmN 
	(for <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 05:42:13 -0400
Received: from siaab1aa.compuserve.com ([149.174.40.1]:29589 "EHLO
	siaab1aa.compuserve.com") by vger.kernel.org with ESMTP
	id S264276AbTDPJmM (for <rfc822;linux-kernel@vger.kernel.org>); Wed, 16 Apr 2003 05:42:12 -0400
Date: Wed, 16 Apr 2003 05:45:20 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: DMA transfers in 2.5.67
To: Mens Rullgerd <mru@users.sourceforge.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-ID: <200304160548_MC3-1-349F-E844@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Btw, I just noticed that hard disk throughput is much lower with 2.5
> than 2.4.  With 2.4.21-pre5 I get ~40 MB/s, but with 2.5.67 the speed
> drops to 25-30 MB/s.  Everything according to hdparm.  Is it possible
> that DMA is generally slow for some reason?


  I am seeing that too, with IDE hardware.

  And 2.4.20aa1 is even faster:



# mount /ext3_fs
# time dd if=/ext3_fs/100MiB_file of=/dev/null bs=32k



  2.4.20aa1 : 3.3 sec (exactly what I expect to see)
  2.5.66    : 6.6 sec


--
 Chuck
