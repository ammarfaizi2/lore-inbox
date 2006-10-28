Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964885AbWJ1WIE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964885AbWJ1WIE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Oct 2006 18:08:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964883AbWJ1WIE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Oct 2006 18:08:04 -0400
Received: from khc.piap.pl ([195.187.100.11]:27102 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S964885AbWJ1WIC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Oct 2006 18:08:02 -0400
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-netdev@vger.kernel.org,
       Jeff Garzik <jgarzik@pobox.com>, akpm@osdl.org
Subject: Re: [PATCH] n2: fix confusing error code
References: <20061028184712.GG9973@localhost>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Sun, 29 Oct 2006 00:07:59 +0200
In-Reply-To: <20061028184712.GG9973@localhost> (Akinobu Mita's message of "Sun, 29 Oct 2006 03:47:12 +0900")
Message-ID: <m38xj0856o.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Akinobu Mita <akinobu.mita@gmail.com> writes:

> modprobe n2 with no parameters or no such devices
> will get confusing error message.
>
> # modprobe n2
> ...  Kernel does not have module support

Now that's interesting :-)

> This patch replaces return code from -ENOSYS to -EINVAL.
>
> Cc: Jeff Garzik <jgarzik@pobox.com>
> Cc: Krzysztof Halasa <khc@pm.waw.pl>
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>

Acked-by: Krzysztof Halasa <khc@pm.waw.pl>.
Jeff, please apply.

Thanks.
-- 
Krzysztof Halasa
