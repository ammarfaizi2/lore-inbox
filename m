Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277330AbRJVAJS>; Sun, 21 Oct 2001 20:09:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277333AbRJVAJI>; Sun, 21 Oct 2001 20:09:08 -0400
Received: from imailg2.svr.pol.co.uk ([195.92.195.180]:17208 "EHLO
	imailg2.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S277330AbRJVAI7>; Sun, 21 Oct 2001 20:08:59 -0400
Date: Mon, 22 Oct 2001 01:09:51 +0100
From: Adam Huffman <bloch@verdurin.com>
To: linux-kernel@vger.kernel.org
Subject: Problem with sd_mod in 2.4.12-ac4
Message-ID: <20011022010951.A1027@bloch.verdurin.priv>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When I try to mount an ext2 partition on an external FireWire
drive, normally sbp2 causes sd_mod to be loaded, and the mount works.

With this kernel, when I modprobe sbp2, sd_mod fails to load.  The error
is:

unresolved symbol blk_ioctl

This works in 2.4.13-pre5 and 2.4.10-ac11.

Adam
