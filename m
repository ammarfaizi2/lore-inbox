Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270526AbTGZSC3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 14:02:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270544AbTGZSC3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 14:02:29 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:2564 "EHLO
	small.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S270526AbTGZSC2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 14:02:28 -0400
Subject: Re: [PATCH] O9int for interactivity
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>, akpm@osdl.org
In-Reply-To: <200307270306.47363.kernel@kolivas.org>
References: <200307270306.47363.kernel@kolivas.org>
Content-Type: text/plain
Message-Id: <1059243458.575.1.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3.99 
Date: Sat, 26 Jul 2003 20:17:38 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-07-26 at 19:06, Con Kolivas wrote:

> Patch applies on top of 2.6.0-test1-mm2 + O8int. A patch against vanilla
> 2.6.0-test1 is also available on my website.

patch-test1-O9 contains some differences with respect to patch-O9 for
the -mm kernels. In the patch-test1-O9, MAX_SLEEP_AVG and
STARVATION_LIMIT are both set to (10*HZ), while in patch-O9-mm2 they are
set to (HZ).

Is this intentional?

