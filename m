Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261234AbVAaIsW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261234AbVAaIsW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 03:48:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261566AbVAaIsW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 03:48:22 -0500
Received: from oceanic.wsisiz.edu.pl ([213.135.44.33]:63842 "EHLO
	oceanic.wsisiz.edu.pl") by vger.kernel.org with ESMTP
	id S261234AbVAaIsT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 03:48:19 -0500
Date: Mon, 31 Jan 2005 09:48:17 +0100 (CET)
From: Lukasz Trabinski <lukasz@oceanic.wsisiz.edu.pl>
To: chas3@users.sourceforge.net
Cc: Mike Westall <westall@cs.clemson.edu>,
       linux-atm-general@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       Bartlomiej Solarz <solarz@wsisiz.edu.pl>
Subject: Re: [Linux-ATM-General] Kernel 2.6.10 and 2.4.29 Oops fore200e (fwd)
In-Reply-To: <200501302255.j0UMtmql020002@ginger.cmf.nrl.navy.mil>
Message-ID: <Pine.LNX.4.61L.0501302357200.7269@oceanic.wsisiz.edu.pl>
References: <200501302255.j0UMtmql020002@ginger.cmf.nrl.navy.mil>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 30 Jan 2005, chas williams - CONTRACTOR wrote:

> In message <Pine.LNX.4.61L.0501302022470.5761@oceanic.wsisiz.edu.pl>,Lukasz Trabinski writes:
>> OK, I think that dirver works much better with udelay() function.
>
> good to hear.  what does atmdiag say about that interface?  does it have
> a large percentage of tx drops?

After 12 hours:

[root@cosmos root]# atmdiag
Itf       TX_okay   TX_err    RX_okay   RX_err    RX_drop
   0 AAL0         0         0         0         0         0
     AAL5  31375820         0  31479406         0         0



-- 
*[ £ukasz Tr±biñski ]*
SysAdmin @wsisiz.edu.pl
