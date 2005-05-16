Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261690AbVEPP0i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261690AbVEPP0i (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 11:26:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261699AbVEPPUG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 11:20:06 -0400
Received: from artemis.thinkingfarm.com ([202.172.234.74]:53669 "EHLO
	artemis.thinkingfarm.com") by vger.kernel.org with ESMTP
	id S261687AbVEPPIW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 11:08:22 -0400
Date: Mon, 16 May 2005 23:07:50 +0800 (SGT)
From: Lai Zit Seng <lzs@pobox.com>
X-X-Sender: lzs@x21.ddns.comp.nus.edu.sg
To: serue@us.ibm.com
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: pivot_root()
In-Reply-To: <20050516135645.GA5842@serge.austin.ibm.com>
Message-ID: <Pine.LNX.4.61.0505162306080.4271@x21.ddns.comp.nus.edu.sg>
References: <42887147.9000302@pobox.com> <20050516135645.GA5842@serge.austin.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes you're right. Thanks!

Regards,

.lzs
http://thinkingfarm.com/~lzs/

On Mon, 16 May 2005 serue@us.ibm.com wrote:
> Try first doing
>
> 	mount --bind <newroot> <newroot>
>
> See the comments above fs/namespace.c:sys_pivot_root() for the
> explanation.
>
> -serge
