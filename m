Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262611AbUCOPyz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 10:54:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262615AbUCOPyz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 10:54:55 -0500
Received: from smtp-out.girce.epro.fr ([195.6.195.146]:58255 "EHLO
	srvsec1.girce.epro.fr") by vger.kernel.org with ESMTP
	id S262611AbUCOPyy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 10:54:54 -0500
Message-ID: <035701c40aa5$1549b490$3cc8a8c0@epro.dom>
From: "Colin Leroy" <colin@colino.net>
To: "Tom Rini" <trini@kernel.crashing.org>
Cc: <benh@kernel.crashing.org>, <linux-kernel@vger.kernel.org>
References: <20040314225913.4654347b@jack.colino.net> <20040315155120.GA4342@smtp.west.cox.net>
Subject: Re: [PATCH] 2.6.4-bk3 ppc32 compile fix
Date: Mon, 15 Mar 2004 16:49:21 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > 2.6.4-bk3 (ie, 2.6.4 + bk3 patch at kernel.org) does not compile
without this patch.
>
> How does it fail to compile?

Same problem as here:
http://marc.theaimsgroup.com/?l=linux-kernel&m=107935807420183&w=2

include/asm/unistd.h:451: syntax error before "long"

(maybe adding the #include <linux/linkage.h> to init/do_mounts_initrd.c is
better than where I did put it).
-- 
Colin

