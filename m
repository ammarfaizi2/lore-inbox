Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751023AbVIAJgr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751023AbVIAJgr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 05:36:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751040AbVIAJgr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 05:36:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:17293 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751023AbVIAJgq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 05:36:46 -0400
From: Andi Kleen <ak@suse.de>
To: Hiro Yoshioka <hyoshiok@miraclelinux.com>
Subject: Re: [RFC] [PATCH] cache pollution aware __copy_from_user_ll()
Date: Thu, 1 Sep 2005 11:36:37 +0200
User-Agent: KMail/1.8
Cc: akpm@osdl.org, torvalds@osdl.org, linux-kernel@vger.kernel.org
References: <20050824.231156.278740508.hyoshiok@miraclelinux.com.suse.lists.linux.kernel> <20050825.135420.640917643.hyoshiok@miraclelinux.com> <20050901.180723.982928921.hyoshiok@miraclelinux.com>
In-Reply-To: <20050901.180723.982928921.hyoshiok@miraclelinux.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509011136.38057.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 01 September 2005 11:07, Hiro Yoshioka wrote:

> The following is the almost final version of the
> cache pollution aware __copy_from_user_ll() patch.

Looks good to me.

Once the filemap.c hunk is in I'll probably do something
similar for x86-64.

-Andi
