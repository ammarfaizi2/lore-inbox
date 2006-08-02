Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932224AbWHBVb4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932224AbWHBVb4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 17:31:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932223AbWHBVb4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 17:31:56 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:13986
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932203AbWHBVbz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 17:31:55 -0400
Date: Wed, 02 Aug 2006 14:32:04 -0700 (PDT)
Message-Id: <20060802.143204.16511279.davem@davemloft.net>
To: cxzhang@us.ibm.com
Cc: catalin.marinas@gmail.com, cxzhang@watson.ibm.com, czhang.us@gmail.com,
       jmorris@namei.org, linux-kernel@vger.kernel.org,
       michal.k.k.piotrowski@gmail.com, netdev@vger.kernel.org,
       sds@tycho.nsa.org
Subject: Re: [Patch] kernel memory leak fix for af_unix datagram getpeersec
 patch
From: David Miller <davem@davemloft.net>
In-Reply-To: <OF2188FBCE.E3CAA317-ON852571BE.00749BCD-852571BE.0074B02B@us.ibm.com>
References: <20060802.141103.35507776.davem@davemloft.net>
	<OF2188FBCE.E3CAA317-ON852571BE.00749BCD-852571BE.0074B02B@us.ibm.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-2022-jp-2
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiaolan Zhang <cxzhang@us.ibm.com>
Date: Wed, 2 Aug 2006 17:14:31 -0400

> I will remember this in the future, I promise.

Can you also remember to test your patches with CONFIG_SECURITY
disabled, as you also promised in the past several times?!??!?!

In file included from init/main.c:34:
include/linux/security.h: In function $,1rx(Bsecurity_release_secctx$,1ry(B:
include/linux/security.h:2757: warning: $,1rx(Breturn$,1ry(B with a value, in function returning void

I'll fix this one up, but this is getting rediculious.
