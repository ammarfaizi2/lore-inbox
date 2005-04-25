Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262671AbVDYP4M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262671AbVDYP4M (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 11:56:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262664AbVDYP4I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 11:56:08 -0400
Received: from colin.muc.de ([193.149.48.1]:53006 "EHLO colin2.muc.de")
	by vger.kernel.org with ESMTP id S262671AbVDYPyE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 11:54:04 -0400
Date: 25 Apr 2005 17:54:03 +0200
Date: Mon, 25 Apr 2005 17:54:03 +0200
From: Andi Kleen <ak@muc.de>
To: Takashi Ikebe <ikebe.takashi@lab.ntt.co.jp>
Cc: Kyle Moffett <mrmacman_g4@mac.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH x86_64] Live Patching Function on 2.6.11.7
Message-ID: <20050425155403.GC65287@muc.de>
References: <4263275A.2020405@lab.ntt.co.jp> <m1y8b9xyaw.fsf@muc.de> <426C51C4.9040902@lab.ntt.co.jp> <e83d0cb60cb50a56b38294e9160d7712@mac.com> <426CC8F7.8070905@lab.ntt.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <426CC8F7.8070905@lab.ntt.co.jp>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2005 at 07:39:51PM +0900, Takashi Ikebe wrote:
> Kyle, thank you so much for your detailed information.
> If you design completely new software, your suggestion is very useful!
> 
> Unfortunately, we carrier have very many exiting software and try to run
> on Linux.
> We need to seek the way which can apply to exiting software also...

ptrace can all do this, even with an existing kernel.
Your full patch is just a funky ptrace equivalent as far as I can see.


-Andi
