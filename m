Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751237AbVI2NFf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751237AbVI2NFf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 09:05:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751242AbVI2NFf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 09:05:35 -0400
Received: from mx.pathscale.com ([64.160.42.68]:4008 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1751237AbVI2NFe (ORCPT
	<rfc822;Linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 09:05:34 -0400
Subject: Re: [discuss] Re: 2.6.14-rc2: x86_64 SMP kernel crashes early
	during boot
From: "Bryan O'Sullivan" <bos@serpentine.com>
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: kiran.th@gmail.com, ak@suse.de, discuss@x86-64.org,
       Linux-kernel@vger.kernel.org
In-Reply-To: <433B306A.3000207@vc.cvut.cz>
References: <1127949243.26892.41.camel@localhost.localdomain>
	 <1127951120.26892.53.camel@localhost.localdomain>
	 <433B306A.3000207@vc.cvut.cz>
Content-Type: text/plain
Date: Thu, 29 Sep 2005 06:05:28 -0700
Message-Id: <1127999128.10913.10.camel@serpentine.pathscale.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-09-29 at 02:08 +0200, Petr Vandrovec wrote:

> Take a look at this (in the '2.6.14-rc1-git-now still dying in mm/slab.c - this 
> time line 1849).

I tried Ravikiran's patch to arch/x86_64/mm/numa.c, and it made no
difference to my crash.

	<b

