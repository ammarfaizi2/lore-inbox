Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261355AbULAK0h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261355AbULAK0h (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 05:26:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261359AbULAK0h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 05:26:37 -0500
Received: from canuck.infradead.org ([205.233.218.70]:11022 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S261355AbULAK0R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 05:26:17 -0500
Subject: Re: Kernel 2.6 with X (xorg) 4.4 (eats more CPU power)
From: Arjan van de Ven <arjan@infradead.org>
To: Joe Hsu <joe@softwell.com.tw>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1101896505.2161.45.camel@joe>
References: <1101896505.2161.45.camel@joe>
Content-Type: text/plain
Message-Id: <1101896767.2640.19.camel@laptop.fenrus.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.dwmw2.1) 
Date: Wed, 01 Dec 2004 11:26:07 +0100
Content-Transfer-Encoding: 7bit
X-Spam-Score: 3.7 (+++)
X-Spam-Report: SpamAssassin version 2.63 on canuck.infradead.org summary:
	Content analysis details:   (3.7 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-12-01 at 18:21 +0800, Joe Hsu wrote:

>     And I found something interisting happened. In pentium 4
> 3.0G machine and linux kernel 2.6, X and my program total 
> consumes 5% of cpu resource.
> 
>     But in pentium 4 2.xG or below, it would consume 10% or 
> more of CPU resource. (If you try this with XFree86 4.2 and 
> pentium 1.xG machine, it would consume 30% or more of cpu 
> resource at a peak.)
> 
>     In contrast, I've tried Kernel 2.4 with same X, same 
> program, and same machine. It consumes almost zero of CPU 
> resource( no matter it runs on a P4 1.xG or P4 3.0G and no
> matter it runs on 4.4 or 4.2 X-server).
> 
>     Same phenomenon happened when I ran 4 mpeg4 playback 
> programs (each 320x240, 30 frames per second, no scaling).
> It seems that these programs and X consume almost zero of 
> CPU power when the KERNEL HZ is 100. (I've 
> tried Robert Love's variable HZ patch to kernel 2.4 and 
> change HZ to 1000........Same phenomenon as 2.6)
> 
>     Could any one explain why??? Thanks.
> (I wish to be personally CC'ed the answers/comments posted 
> to the list in response to your posting 'cause I do not 
> subscribe to this mailing list.)
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 

