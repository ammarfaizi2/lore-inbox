Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262872AbVCPXK7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262872AbVCPXK7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 18:10:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262869AbVCPXHs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 18:07:48 -0500
Received: from mailer.gwdg.de ([134.76.10.26]:6784 "EHLO mailer.gwdg.de")
	by vger.kernel.org with ESMTP id S262874AbVCPXEI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 18:04:08 -0500
Date: Thu, 17 Mar 2005 00:04:04 +0100 (CET)
From: Eberhard Moenkeberg <emoenke@gwdg.de>
To: Jesper Juhl <juhl-lkml@dif.dk>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] small fixes for example programs in Documentation/cdrom/sbpcd
In-Reply-To: <Pine.LNX.4.62.0503162210250.2558@dragon.hyggekrogen.localhost>
Message-ID: <Pine.LNX.4.61.0503162353140.25585@gwdu05.gwdg.de>
References: <Pine.LNX.4.62.0503162210250.2558@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 16 Mar 2005, Jesper Juhl wrote:

> Example programs in documentation files are great, but they are even
> better when they compile :)
>
> The second one, the "cdtester" utility, is still not completely happy, but
> at least the patch fixes up most of the warnings and errors when trying to
> build it. The first app is perfectly happy here after this patch.

Thanks.
One small correction: your words "still not" should read "no longer".
Because old happiness already lasted more than 10 years (I guess 11, 
because my son has grown to 23 meanwhile).

> -main(int argc, char *argv[])
> +int main(int argc, char *argv[])

> +    return 0;

> -#endif SBP_PRIVATE_IOCTLS
> +#endif /* SBP_PRIVATE_IOCTLS */

> -#endif AZT_PRIVATE_IOCTLS
> +#endif /* AZT_PRIVATE_IOCTLS */

> -main(int argc, char *argv[])
> +int main(int argc, char *argv[])

> -#endif SBP_PRIVATE_IOCTLS
> +#endif /* SBP_PRIVATE_IOCTLS */
> +	return 0;

Do it.
I'm kind of proud, only "cosmetical" changes after a whole 
decennium. ;-))

Cheers -e
-- 
Eberhard Moenkeberg (emoenke@gwdg.de, em@kki.org)
