Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261938AbVANK1t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261938AbVANK1t (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 05:27:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261939AbVANK1t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 05:27:49 -0500
Received: from [213.85.13.118] ([213.85.13.118]:27008 "EHLO tau.rusteko.ru")
	by vger.kernel.org with ESMTP id S261938AbVANK1q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 05:27:46 -0500
To: Andi Kleen <ak@muc.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc1-mm1
References: <20050114002352.5a038710.akpm@osdl.org> <m1zmzcpfca.fsf@muc.de>
From: Nikita Danilov <nikita@clusterfs.com>
Date: Fri, 14 Jan 2005 13:27:27 +0300
In-Reply-To: <m1zmzcpfca.fsf@muc.de> (Andi Kleen's message of "Fri, 14 Jan
 2005 09:47:17 +0100")
Message-ID: <m17jmg2tm8.fsf@clusterfs.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.5 (chayote, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@muc.de> writes:

[...]

>
> Preferably that would be only the fastest options (extremly simple
> per CPU buffer with inlined fast path that drop data on buffer overflow), 

Logging mechanism that loses data is worse than useless. It's only too
often that one spends a lot of time trying to reproduce some condition
with logging on, only to find out that nothing was logged.

[...]

>
> -Andi

Nikita.

