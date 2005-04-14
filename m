Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261425AbVDNK6S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261425AbVDNK6S (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Apr 2005 06:58:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261432AbVDNK6S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Apr 2005 06:58:18 -0400
Received: from mail-in-05.arcor-online.net ([151.189.21.45]:56215 "EHLO
	mail-in-05.arcor-online.net") by vger.kernel.org with ESMTP
	id S261425AbVDNK6R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Apr 2005 06:58:17 -0400
From: "Bodo Eggert <harvested.in.lkml@posting.7eggert.dyndns.org>" 
	<7eggert@gmx.de>
Subject: Re: encrypted swap (was Re: [PATCH encrypted swsusp 1/3] core functionality)
To: Andy Isaacson <adi@hexapodia.org>,
       Herbert Xu <herbert@gondor.apana.org.au>, Pavel Machek <pavel@ucw.cz>,
       Andreas Steinmetz <ast@domdv.de>, rjw@sisk.pl,
       linux-kernel@vger.kernel.org
Reply-To: 7eggert@gmx.de
Date: Thu, 14 Apr 2005 12:57:50 +0200
References: <3SZMt-3zo-15@gated-at.bofh.it> <3T83r-1Mk-35@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
Message-Id: <E1DM22j-0000nq-OY@be1.7eggert.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Isaacson <adi@hexapodia.org> wrote:

>  * the key is automatically regenerated every 2 hours (or whatever); as
>    pages encrypted under the old key age out, it can be freed eventually

Changing the key would not help, since if you can get the swap pages on
a running system, you can also get the keys, and if you are using a limited
set of keys (you obviously want that), using more than one key will just add
a small linear factor to cracking the whole swap data of an offline system.
-- 
Field experience is something you don't get until just after you need it. 

Friﬂ, Spammer: info@fibelckn.info webmaster@tlcks.com borrowed@jebafdef.info
 graspable9755@incbggc.info zm-e@bnik.com several@sanction6029biz.us
