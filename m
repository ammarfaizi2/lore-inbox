Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266349AbUFZRa2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266349AbUFZRa2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jun 2004 13:30:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267194AbUFZRa1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jun 2004 13:30:27 -0400
Received: from umhlanga.stratnet.net ([12.162.17.40]:48268 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S266349AbUFZRaX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jun 2004 13:30:23 -0400
To: Christoph Hellwig <hch@infradead.org>
Cc: long <tlnguyen@snoqualmie.dp.intel.com>, linux-kernel@vger.kernel.org,
       ak@muc.de, akpm@osdl.org, greg@kroah.com, jgarzik@pobox.com,
       tom.l.nguyen@intel.com, zwane@linuxpower.ca
Subject: Re: [PATCH]2.6.7 MSI-X Update
X-Message-Flag: Warning: May contain useful information
References: <200406260121.i5Q1LwK0005068@snoqualmie.dp.intel.com>
	<52n02r14ki.fsf@topspin.com> <20040626082713.GA11693@infradead.org>
From: Roland Dreier <roland@topspin.com>
Date: Sat, 26 Jun 2004 10:30:20 -0700
In-Reply-To: <20040626082713.GA11693@infradead.org> (Christoph Hellwig's
 message of "Sat, 26 Jun 2004 09:27:14 +0100")
Message-ID: <523c4i1b2r.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 26 Jun 2004 17:30:20.0236 (UTC) FILETIME=[410CA0C0:01C45BA3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Roland> As a concrete example, the e1000 net driver does
    Roland> request_irq() in its e1000_up() function and free_irq() in
    Roland> its e1000_down() function.  Basically, the driver will do
    Roland> request_irq() when the user does "ifconfig up" and
    Roland> free_irq() when the user does "ifconfig down".

    Christoph> Lots of networking drivers do that..

Yup, I just wanted to pick one definite example so I could point to
real function names, etc.  (And also I wanted to pick a piece of
hardware that I happen to know is MSI-capable).

Thanks,
  Roland
