Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261372AbVBNJSq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261372AbVBNJSq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 04:18:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261373AbVBNJSq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 04:18:46 -0500
Received: from one.firstfloor.org ([213.235.205.2]:17286 "EHLO
	one.firstfloor.org") by vger.kernel.org with ESMTP id S261372AbVBNJSp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 04:18:45 -0500
To: Piotr Kaczuba <pepe@attika.ath.cx>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PCI access mode on x86_64
References: <20050213213117.GA18812@attika.ath.cx>
From: Andi Kleen <ak@muc.de>
Date: Mon, 14 Feb 2005 10:18:43 +0100
In-Reply-To: <20050213213117.GA18812@attika.ath.cx> (Piotr Kaczuba's message
 of "Sun, 13 Feb 2005 22:31:17 +0100")
Message-ID: <m1oeenh53g.fsf@muc.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Piotr Kaczuba <pepe@attika.ath.cx> writes:

> Hi!
>
> Is there a reason why "PCI access mode" config option isn't available for
> x86_64? Due to this, PCIE config options aren't available either.

There is no 64bit PCI BIOS, so access is always direct.

I assume you mean mmconfig access with "PCIE config options", that is
a separate config option and available.

-Andi
