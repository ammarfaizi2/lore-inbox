Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268832AbUJKLmS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268832AbUJKLmS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 07:42:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268831AbUJKLmS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 07:42:18 -0400
Received: from smtp204.mail.sc5.yahoo.com ([216.136.130.127]:47971 "HELO
	smtp204.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S268819AbUJKLmR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 07:42:17 -0400
Message-ID: <416A70AA.3040608@yahoo.com.au>
Date: Mon, 11 Oct 2004 21:38:18 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc4-mm1
References: <20041011032502.299dc88d.akpm@osdl.org>
In-Reply-To: <20041011032502.299dc88d.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc4/2.6.9-rc4-mm1/

> +no-wild-kswapd-2.patch

Is this an improvement? It again decouples the "priority" semantics of
the direct and asynch reclaim paths. Seems to make things more complex
in general.
