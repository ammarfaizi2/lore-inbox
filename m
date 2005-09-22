Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751210AbVIVXlY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751210AbVIVXlY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 19:41:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751212AbVIVXlY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 19:41:24 -0400
Received: from hera.kernel.org ([140.211.167.34]:8095 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1751210AbVIVXlX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 19:41:23 -0400
Date: Thu, 22 Sep 2005 20:27:19 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: linux-kernel@vger.kernel.org
Subject: Linux 2.4.32-rc1
Message-ID: <20050922232719.GA5805@dmt.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here goes the first -rc of v2.4.32, containing a set of small
corrections here and there, most of them being fixes backported from
v2.6.

Summary of changes from v2.4.32-pre3 to v2.4.32-rc1
============================================

Andrey J. Melnikoff:
  Remove isofs useless unsigned " < 0" comparison

Assar:
  nfs client: handle long symlinks properly

Chuck Ebbert:
  i386: fix incorrect FP signal delivery

Dave Johnson:
  [IPV4]: Fix negative timer loop with lots of ipv4 peers.

Gustavo Zacarias:
  [SPARC64]: Use vmalloc() in do_netfilter_replace()

Hasso Tepper:
  [IPV6]: Route events reported with wrong netlink PID and seq number

Horms:
  CAN-2005-0204: AMD64, allows local users to write to privileged IO ports via OUTS instruction
  isofs driver ignore parameters

Jean Delvare:
  update lm_sensors mailing list address

Kirill Korotaev:
  Lost sockfd_put() in routing_ioctl()
  lost fput in 32bit ioctl on x86-64

Kiyoshi Ueda:
  IA64: page_not_present fault in region 5 is normal

M.Baris Demiray:
  Update PPPoE's configuration documentation

Marcelo Tosatti:
  NFS: dprintk on -ENAMETOOLONG error handling
  Update VERSION to 2.4.32-rc1
  Andrea Arcangeli: avoid size_buffers_type overflow
  Merge master.kernel.org:/.../davem/net-2.4
  Revert unnecessary arch/ppc64/boot/zlib.c
  Revert unnecessary zlib_inflate/inftress.c fix

mikem:
  cciss 2.4.60

Patrick McHardy:
  [NETFILTER]: Handle NAT module load race

