Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263713AbUGHNML@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263713AbUGHNML (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 09:12:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264595AbUGHNMK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 09:12:10 -0400
Received: from khan.acc.umu.se ([130.239.18.139]:51967 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id S264396AbUGHNKK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 09:10:10 -0400
Date: Thu, 8 Jul 2004 15:10:07 +0200
From: David Weinehall <tao@acc.umu.se>
To: Andrey Panin <pazke@donpac.ru>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] 2.6.7-mm6, fix CRC16 misnaming
Message-ID: <20040708131007.GC10540@khan.acc.umu.se>
Mail-Followup-To: Andrey Panin <pazke@donpac.ru>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <10892916781086@donpac.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10892916781086@donpac.ru>
User-Agent: Mutt/1.4.1i
X-Accept-Language: Swedish, English
X-GPG-Fingerprint: 7ACE 0FB0 7A74 F994 9B36  E1D1 D14E 8526 DC47 CA16
X-GPG-Key: http://www.acc.umu.se/~tao/files/pubkey_dc47ca16.gpg.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 08, 2004 at 05:01:18PM +0400, Andrey Panin wrote:
[snip]
> -config CRC16
> -	tristate "CRC16 functions"
> +config CRC_CCITT
> +	tristate "CRC-CCITT functions"

Wouldn't it be better to keep the size here too?

CRC16-CCITT instead of just CRC-CCITT.


Regards: David Weinehall
-- 
 /) David Weinehall <tao@acc.umu.se> /) Northern lights wander      (\
//  Maintainer of the v2.0 kernel   //  Dance across the winter sky //
\)  http://www.acc.umu.se/~tao/    (/   Full colour fire           (/
