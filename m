Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262301AbVAZNqQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262301AbVAZNqQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 08:46:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262300AbVAZNqQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 08:46:16 -0500
Received: from gate.crashing.org ([63.228.1.57]:18129 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262297AbVAZNqN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 08:46:13 -0500
Subject: Re: Problem with cpu_rest() change
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <kumar.gala@freescale.com>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <7E912176-6F5D-11D9-986F-000393DBC2E8@freescale.com>
References: <1106696952.6244.22.camel@gaston>
	 <7E912176-6F5D-11D9-986F-000393DBC2E8@freescale.com>
Content-Type: text/plain
Date: Thu, 27 Jan 2005 00:44:57 +1100
Message-Id: <1106747097.6249.58.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-01-25 at 23:45 -0600, Kumar Gala wrote:
> Will these changes cause us to back out the patch already made to 
> arch/ppc/kernel/idle.c for systems that did not support powersavings?

Did it already make it upstream ? Ingo's fix should make our workarounds
unnecessary indeed...

Ben.


