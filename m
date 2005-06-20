Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261567AbVFTUdI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261567AbVFTUdI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 16:33:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261581AbVFTUcw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 16:32:52 -0400
Received: from soufre.accelance.net ([213.162.48.15]:63959 "EHLO
	soufre.accelance.net") by vger.kernel.org with ESMTP
	id S261567AbVFTU3i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 16:29:38 -0400
Message-ID: <42B7272F.2040503@xenomai.org>
Date: Mon, 20 Jun 2005 22:29:35 +0200
From: Philippe Gerum <rpm@xenomai.org>
Organization: Xenomai
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] I-pipe: Core implementation
References: <42B35B07.7080703@xenomai.org> <20050618170139.GA477@openzaurus.ucw.cz>
In-Reply-To: <20050618170139.GA477@openzaurus.ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

Pavel Machek wrote:
> Hi!
> 
> 
>> linux-2.6.12-rc6-ipipe-0.5/ipipe/Kconfig         |   12
>> linux-2.6.12-rc6-ipipe-0.5/ipipe/Makefile        |    9
>> linux-2.6.12-rc6-ipipe-0.5/ipipe/generic.c       |  265 ++++++++++++
> 
> 
> Top-level directory for 3 files seems a bit excessive to me...
> 				Pavel

There's a fourth one (ipipe/x86.c) added by the arch-dependent patch, 
but yes, I agree that this could sound rather overkill to have this 
support in its own dir, especially a top-level one. The files under 
ipipe/ can be built as a loadable module, hence the current layout.
Would you see this belonging to, e.g., the driver tree instead?

-- 

Philippe.
