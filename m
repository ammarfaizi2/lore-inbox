Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262349AbVC3RO6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262349AbVC3RO6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 12:14:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262353AbVC3RO6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 12:14:58 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:2467 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262349AbVC3ROu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 12:14:50 -0500
Date: Wed, 30 Mar 2005 09:15:01 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: linux-kernel@vger.kernel.org
Subject: Linux 2.4.30-rc4
Message-ID: <20050330121500.GA7390@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here goes -rc4 to fix a couple of regressions have been confirmed: 

- ext3 IO EH changes need more work
- Netfilter bogus mc_list deletion

Hopefully this will become final in a day or two.


Summary of changes from v2.4.30-rc3 to v2.4.30-rc4
============================================

Herbert Xu:
  o [NETLINK] Fix bogus mc_list deletion

Marcelo Tosatti:
  o Cset exclude: hifumi.hisashi@lab.ntt.co.jp|ChangeSet|20050226095914|25750
  o Change VERSION to 2.4.30-rc4

Willy Tarreau:
  o Keith Owens: modutils >= 2.4.14 is required for MODVERSIONS+EXPORT_SYMBOL_GPL() combination


