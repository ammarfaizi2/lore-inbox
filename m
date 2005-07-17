Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261440AbVGQXAW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261440AbVGQXAW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Jul 2005 19:00:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261441AbVGQXAW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Jul 2005 19:00:22 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:1210 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S261440AbVGQXAU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Jul 2005 19:00:20 -0400
Date: Mon, 18 Jul 2005 00:57:01 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: AndyLiebman@aol.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.10 Kernel Goes Crazy After Resetting MTU
Message-ID: <20050717225701.GA28994@electric-eye.fr.zoreil.com>
References: <7e.6d9bff30.300c1cd5@aol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e.6d9bff30.300c1cd5@aol.com>
User-Agent: Mutt/1.4.2.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

AndyLiebman@aol.com <AndyLiebman@aol.com> :
[2.6.10 + e1000 + page allocation failure]
> Any ideas? 

- upgrade 
- increase vm.min_free_kbytes
- renice kswapd
- Cc: Nick Piggin and netdev@vger.kernel.org

--
Ueimor
