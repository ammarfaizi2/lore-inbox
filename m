Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265656AbTF2NCL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jun 2003 09:02:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265658AbTF2NCK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jun 2003 09:02:10 -0400
Received: from [66.212.224.118] ([66.212.224.118]:39942 "EHLO
	hemi.commfireservices.com") by vger.kernel.org with ESMTP
	id S265656AbTF2NCG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jun 2003 09:02:06 -0400
Date: Sun, 29 Jun 2003 09:04:57 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Manfred Spraul <manfred@colorfullife.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: Oops in __change_page_attr Re: (was 2.5.73-mm2)
In-Reply-To: <3EFEE38C.1070307@colorfullife.com>
Message-ID: <Pine.LNX.4.53.0306290858350.1878@montezuma.mastecende.com>
References: <Pine.LNX.4.53.0306290806230.1878@montezuma.mastecende.com>
 <Pine.LNX.4.53.0306290830080.1878@montezuma.mastecende.com>
 <3EFEE38C.1070307@colorfullife.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 29 Jun 2003, Manfred Spraul wrote:

> Could you try the attached patch?
> The code tries to map/unmap highmem pages on the fly, and that fails, 
> because highmem pages are never mapped.

Thanks, that fixes it =)

-- 
function.linuxpower.ca
