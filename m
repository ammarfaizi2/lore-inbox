Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261185AbVAMQc3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261185AbVAMQc3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 11:32:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261211AbVAMQcL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 11:32:11 -0500
Received: from box3.punkt.pl ([217.8.180.76]:64529 "HELO box.punkt.pl")
	by vger.kernel.org with SMTP id S261185AbVAMQao (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 11:30:44 -0500
From: Mariusz Mazur <mmazur@kernel.pl>
To: Jakub Jelinek <jakub@redhat.com>
Subject: Re: [ANNOUNCE] linux-libc-headers 2.6.10.0
Date: Thu, 13 Jan 2005 17:29:58 +0100
User-Agent: KMail/1.7.1
Cc: Rahul Karnik <deathdruid@gmail.com>, Andrew Walrond <andrew@walrond.org>,
       linux-kernel@vger.kernel.org
References: <200501081613.27460.mmazur@kernel.pl> <5b64f7f050113034640e28eb9@mail.gmail.com> <20050113115154.GW10340@devserv.devel.redhat.com>
In-Reply-To: <20050113115154.GW10340@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200501131729.58803.mmazur@kernel.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On czwartek 13 styczeñ 2005 12:51, Jakub Jelinek wrote:
> For kernel modules you should never use /usr/include headers though.
> /lib/modules/`uname -r`/build/include headers should be used for them
> instead.

Exactly (more or less - I don't always need to build against the kernel I'm 
running - especially when building distro rpms).

*Any* sane userland application should avoid static dependencies on current 
kernel config *at* *all* *cost*.


-- 
In the year eighty five ten
God is gonna shake his mighty head
He'll either say,
"I'm pleased where man has been"
Or tear it down, and start again
