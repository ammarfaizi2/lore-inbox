Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030340AbVIOC1v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030340AbVIOC1v (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 22:27:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030348AbVIOC1v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 22:27:51 -0400
Received: from smtp.osdl.org ([65.172.181.4]:32979 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030340AbVIOC1v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 22:27:51 -0400
Date: Wed, 14 Sep 2005 19:26:52 -0700
From: Andrew Morton <akpm@osdl.org>
To: David Lang <dlang@digitalinsight.com>
Cc: chrisw@osdl.org, linux-kernel@vger.kernel.org, stable@kernel.org,
       jmforbes@linuxtx.org, zwane@arm.linux.org.uk, tytso@mit.edu,
       rdunlap@xenotime.net, chuckw@quantumlinux.com, torvalds@osdl.org,
       alan@lxorguk.ukuu.org.uk
Subject: Re: [PATCH 04/11] hpt366: write the full 4 bytes of ROM address,
 not just low 1 byte
Message-Id: <20050914192652.02cf8fd8.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.62.0509141917070.8469@qynat.qvtvafvgr.pbz>
References: <20050915010343.577985000@localhost.localdomain>
	<20050915010404.660502000@localhost.localdomain>
	<Pine.LNX.4.62.0509141917070.8469@qynat.qvtvafvgr.pbz>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Lang <dlang@digitalinsight.com> wrote:
>
> didn't Linus find similar bugs in a couple of the other hpt drivers as 
>  well? if so can they be fixed at the same time?

Adam Kropelin did a sweep and picked up four similar cases.  I queued the
patches and they should be considered for 2.6.13.3
