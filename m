Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261464AbUAFIlz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 03:41:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261500AbUAFIlz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 03:41:55 -0500
Received: from viefep20-int.chello.at ([213.46.255.26]:31064 "EHLO
	viefep20-int.chello.at") by vger.kernel.org with ESMTP
	id S261464AbUAFIly (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 03:41:54 -0500
From: Andreas Theofilu <noreply@TheosSoft.net>
Subject: Re: problem booting aic7xxx-old with reiserfs
To: martin f krafft <madduck@madduck.net>,
       linux-kernel <linux-kernel@vger.kernel.org>
Date: Tue, 06 Jan 2004 09:41:52 +0100
References: <1aMb6-3Fs-37@gated-at.bofh.it>
Organization: Theos Soft
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Message-Id: <20040106084152.7B47D52003@chello062178157104.9.14.vie.surfer.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

martin f krafft wrote:

> [please CC me on replies!]
> 
> Hi all,
> 
> I configured the 2.6.0 kernel [2] with the old aic7xxx driver, as well
> as the 3c59x and 8139too drivers. Now, when I start the system, it
> loads the kernel just fine, the SCSI driver recognises the
> harddrive, but when it tries to mount / (reiserfs) (right after
> initialising TCP, GRE, IPsec, IPv6 and SCTP), it just hangs with the

The old aic7xxx driver seems to be broken. Whenever possible use the new
AIC7xxx driver. It works perfect here.

-- 
Andreas Theofilu
http://www.TheosSoft.net
E-Mail: andreas at TheosSoft dot net
