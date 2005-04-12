Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262968AbVDLXRx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262968AbVDLXRx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 19:17:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263049AbVDLXOe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 19:14:34 -0400
Received: from gate.crashing.org ([63.228.1.57]:57766 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262978AbVDLXLy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 19:11:54 -0400
Subject: Re: ATI Radeon 9000 M9 mobitility troubles on linux 2.6
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bastian Beutner <tevid411@gmail.com>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <425C0E60.7000708@gmail.com>
References: <425C0E60.7000708@gmail.com>
Content-Type: text/plain
Date: Wed, 13 Apr 2005 09:10:31 +1000
Message-Id: <1113347431.5388.123.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-04-12 at 14:07 -0400, Bastian Beutner wrote:
> dmesg for linux 2.4
> 
> agpgart: Detected an Intel(R) 845G, but could not find the secondary 
> device. Assuming a non-integrated video card
> 
> dmesg for linux 2.6
> 
> agpgart: Detected an Intel(R) 845G
> 
> on 2.6 x will start with vesa but due to this being a laptop i cannot do 
> 1400 x 1050
> 
> radeon and/or fglrx drivers will not start X on 2.6 but will start X on 2.4

Can you send the X log on both ?

> lspci shows the card as being there under 2.6 and 2.4 as follows
> 
> 0000:01:00.0 VGA compatible controller: ATI Technologies Inc Radeon R250 
> Lf [FireGL 9000] (rev 01)
> 
> tried setting BUSID in X config but to no avail X will not detect the card
> 
> any ideas?
> 
> please CC me the answers
> 
> tevid
> 
> Linux scion 2.4.28-gentoo-r7 #6 Thu Mar 31 03:37:29 EST 2005 i686 
> Intel(R) Pentium(R) 4 CPU 2.66GHz GenuineIntel GNU/Linux
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
Benjamin Herrenschmidt <benh@kernel.crashing.org>

