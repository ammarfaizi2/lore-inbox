Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261604AbVAMLw3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261604AbVAMLw3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 06:52:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261602AbVAMLw2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 06:52:28 -0500
Received: from mx1.redhat.com ([66.187.233.31]:17288 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261604AbVAMLwG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 06:52:06 -0500
Date: Thu, 13 Jan 2005 06:51:54 -0500
From: Jakub Jelinek <jakub@redhat.com>
To: Rahul Karnik <deathdruid@gmail.com>
Cc: Andrew Walrond <andrew@walrond.org>, Mariusz Mazur <mmazur@kernel.pl>,
       linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] linux-libc-headers 2.6.10.0
Message-ID: <20050113115154.GW10340@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <200501081613.27460.mmazur@kernel.pl> <200501130813.42545.andrew@walrond.org> <200501131042.25470.mmazur@kernel.pl> <200501131100.19500.andrew@walrond.org> <5b64f7f050113034640e28eb9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b64f7f050113034640e28eb9@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 13, 2005 at 06:46:32AM -0500, Rahul Karnik wrote:
> We are not talking about an application, but rather out of tree kernel
> modules (or rather, different versions of modules already in the
> tree).

For kernel modules you should never use /usr/include headers though.
/lib/modules/`uname -r`/build/include headers should be used for them
instead.

	Jakub
