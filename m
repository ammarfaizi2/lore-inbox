Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263298AbTJ0FSP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 00:18:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263760AbTJ0FSP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 00:18:15 -0500
Received: from smtp1.clear.net.nz ([203.97.33.27]:4831 "EHLO
	smtp1.clear.net.nz") by vger.kernel.org with ESMTP id S263298AbTJ0FSN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 00:18:13 -0500
Date: Mon, 27 Oct 2003 18:17:59 +1300
From: Nigel Cunningham <ncunningham@clear.net.nz>
Subject: re: Linux 2.6 features list update
In-reply-to: <E1ADzPx-0002Hl-00@penngrove.fdns.net>
To: John Mock <kd6pag@qsl.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <1067231878.26324.2.camel@laptop-linux>
Organization: 
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.2.2
Content-type: text/plain
Content-transfer-encoding: 7bit
References: <E1ADzPx-0002Hl-00@penngrove.fdns.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I don't use it myself, but I believe some of the users of the 2.4
version (which is what has just been ported to 2.6) are successfully
utilising USB and ieee1394 there (without the driver model!). There's no
great difference in the ported version, so it should work or be able to
be made to work with the port, even if (unlikely) there's something
fundamentally different in Patrick & Pavel's implementations that will
prohibit it from working.

Regards.

Nigel

On Mon, 2003-10-27 at 17:55, John Mock wrote:
> I think the section entitled "Laptops" is overly optimistic.  First,
> as far as i know, suspend-to-disk has only this week been announced
> (on this mailing list) for anything other than the i386 platform, and
> even there, many laptops only marginally work with software suspend/
> suspend-to-disk.  I really doubt that any file system utilizing USB or
> ieee1394 is going to work reliably (if at all) with suspend for many
> laptops in the near future.  I think the 2.6.0 shakedown and the amount
> of attention (or lack thereof) given to suspend-related bugs makes it
> clear that suspend-to-disk/software suspend is still experimental in
> this release.
> 
> I sincerely hope that changes very soon and i will do what i can to 
> help.  Meanwhile, please qualify that section to read:
> 
>    ... now supports full software-suspend-to-disk functionality on many
> 								-------
>    laptops for the Linux user on the go.
>    -------				  [emphasis to show added text]
> 
> It's definitely improved, but in many instances (especially where the 
> laptop manufacturer has not provided full hardware/BIOS documentation),
> it does not work well and may be difficult to make reliable in the near
> future.
> 
> Respectfully submitted,
> 				-- JM
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
Nigel Cunningham
495 St Georges Road South, Hastings 4201, New Zealand

Evolution (n): A hypothetical process whereby infinitely improbable events occur 
with alarming frequency, order arises from chaos, and no one is given credit.

