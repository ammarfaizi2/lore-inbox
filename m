Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030514AbWHUOYT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030514AbWHUOYT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 10:24:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030515AbWHUOYT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 10:24:19 -0400
Received: from ns.suse.de ([195.135.220.2]:44995 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1030514AbWHUOYS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 10:24:18 -0400
From: Andi Kleen <ak@suse.de>
To: vgoyal@in.ibm.com
Subject: Re: [Fastboot] [PATCH][RFC] x86_64: Reload CS when startup_64 is used.
Date: Mon, 21 Aug 2006 16:24:10 +0200
User-Agent: KMail/1.9.3
Cc: Magnus Damm <magnus.damm@gmail.com>, Magnus Damm <magnus@valinux.co.jp>,
       fastboot@lists.osdl.org, linux-kernel@vger.kernel.org,
       ebiederm@xmission.com
References: <20060821095328.3132.40575.sendpatchset@cherry.local> <aec7e5c30608210629r4f2cf5dlfb1ad7d6cc95745d@mail.gmail.com> <20060821141721.GA29498@in.ibm.com>
In-Reply-To: <20060821141721.GA29498@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608211624.11005.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Given the idea of relocatable kernel is floating around I would prefer if
> we are not bounded by the restriction of loading a kernel in lowest 4G.

There is already other code that requires this. In fact i don't think it can
be above 40MB currently.

-Andi
