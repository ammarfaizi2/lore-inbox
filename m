Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751779AbWEPLBd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751779AbWEPLBd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 07:01:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751776AbWEPLBd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 07:01:33 -0400
Received: from mail.axxeo.de ([82.100.226.146]:44204 "EHLO mail.axxeo.de")
	by vger.kernel.org with ESMTP id S1751771AbWEPLBc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 07:01:32 -0400
From: Ingo Oeser <netdev@axxeo.de>
Organization: Axxeo GmbH
To: Chris Boot <bootc@bootc.net>
Subject: Re: KERNEL: assertion (!sk->sk_forward_alloc) failed at net/* (again)
Date: Tue, 16 May 2006 13:01:45 +0200
User-Agent: KMail/1.9.1
References: <16537920-30DB-4FF7-BD51-DC8517BF4321@bootc.net>
In-Reply-To: <16537920-30DB-4FF7-BD51-DC8517BF4321@bootc.net>
Cc: kernel list <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
       grsecurity@grsecurity.net
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605161301.46030.netdev@axxeo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chris,

here are some steps to narrow it down.

1. try the latest kernel first (2.6.16.16). This BUG should be fixed there.
2. try without grsecurity patch 
3. if it still persists:

	Please provide more information about your setup before
	submitting a bug.

	lspci -vvv and your .config would be the minimum
	some ethtool outputs (ethtool -k ethX) would help here.

4. If you like to have it resolved very fast, please try git-bisect.
    This can take a lot of time (several recompiles and reboots needed!).

Happy Bug hunting!

Regards

Ingo Oeser
