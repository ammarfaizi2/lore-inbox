Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269935AbTGKMyT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 08:54:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269937AbTGKMyS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 08:54:18 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:48525 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S269935AbTGKMyS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 08:54:18 -0400
Date: Fri, 11 Jul 2003 15:08:59 +0200
From: bert hubert <ahu@ds9a.nl>
To: andries.brouwer@cwi.nl
Cc: linux-kernel@vger.kernel.org
Subject: what is needed to test the in-kernel crypto loop?
Message-ID: <20030711130859.GA15013@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>, andries.brouwer@cwi.nl,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries,

You mentioned:

 [util-linux is waiting for this; when 2.6 comes out, or the
  first mount/losetup comes out that uses struct loop_info64,
  whichever comes first, struct loop_info64 must be considered
  frozen: a stable kernel must not change API and user space
  ABI must remain constant. This means that if cryptoloop is
  added later, some backwards compatibility is lost.]

Is a newer losetup/mount needed to test the in-kernel crypto loop driver?
The crypto-loop code is present in the bk repository, now.

Thanks.

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
