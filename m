Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262474AbVCBURd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262474AbVCBURd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 15:17:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262455AbVCBUQa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 15:16:30 -0500
Received: from mail.gondor.com ([212.117.64.182]:62479 "EHLO moria.gondor.com")
	by vger.kernel.org with ESMTP id S262447AbVCBUGc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 15:06:32 -0500
Date: Wed, 2 Mar 2005 21:06:32 +0100
From: Jan Niehusmann <jan@gondor.com>
To: linux-kernel@vger.kernel.org
Subject: bouncing keys and skipping sound with 2.6.11
Message-ID: <20050302200632.GA24529@gondor.com>
References: <Pine.LNX.4.58.0503012356480.25732@ppc970.osdl.org> <20050228184414.GA31929@gondor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0503012356480.25732@ppc970.osdl.org> <20050228184414.GA31929@gondor.com>
X-Request-PGP: http://gondor.com/key.asc
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

the problem with bouncing keys I reported with 2.6.11-rc5 is still
present in 2.6.11. Additionally, I noticed that audio has short outages
every few seconds, which sound like latency problems would do.

And I saw with 'top' that often, when the sound skips, the kacpid process
shows up using a big percentage of CPU time. (Perhaps it's always the kacpid
waking up, but 'top' is just to slow to show it accurately)

Have there been changes between 2.6.10 and 2.6.11-rc5 which could cause
these problems, perhaps together with ACPI bugs on the ASUS M2400N or
anything like that? I'd be happy helping to debug this, if anybody could
give me a hint where to start.

Yours,
Jan

