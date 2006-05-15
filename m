Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932268AbWEOQXT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932268AbWEOQXT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 12:23:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932251AbWEOQXT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 12:23:19 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:9445 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932246AbWEOQXS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 12:23:18 -0400
Subject: Re: 2.6.15-rc1: IDE: fix potential data corruption with SL82C105
	interfaces
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <4468A6E2.5060305@ru.mvista.com>
References: <20051112165548.GB28987@flint.arm.linux.org.uk>
	 <1131818615.18258.6.camel@localhost.localdomain>
	 <446890F0.3020408@ru.mvista.com>
	 <1147706716.26686.64.camel@localhost.localdomain>
	 <4468A6E2.5060305@ru.mvista.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 15 May 2006 17:35:51 +0100
Message-Id: <1147710951.26686.76.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2006-05-15 at 20:05 +0400, Sergei Shtylyov wrote:

The chips may be dual channel, none of the users I have access to are
using the second channel ..

>     Ah, that register 0x7E reset? Strangely, W83C55[34]F datasheets don't even 
> mention it. :-/

Its in the errata document for the ones I have. You want "W83C553F-G
Engineering Notice Nov 19 2001"


