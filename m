Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751253AbWHUW1b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751253AbWHUW1b (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 18:27:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751254AbWHUW1b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 18:27:31 -0400
Received: from ns1.suse.de ([195.135.220.2]:32430 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751253AbWHUW1a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 18:27:30 -0400
Date: Tue, 22 Aug 2006 00:27:28 +0200
From: Andi Kleen <ak@suse.de>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org, Roman Zippel <zippel@linux-m68k.org>
Subject: Re: [2.6 patch] re-add -ffreestanding
Message-Id: <20060822002728.c023bf85.ak@suse.de>
In-Reply-To: <20060821222412.GS11651@stusta.de>
References: <20060821212154.GO11651@stusta.de>
	<20060821232444.9a347714.ak@suse.de>
	<20060821214636.GP11651@stusta.de>
	<20060822000903.441acb64.ak@suse.de>
	<20060821222412.GS11651@stusta.de>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> It disables the automatic usage of builtins which is OK.

No, it's not ok -- it is the problem. We want to use the builtins.

-Andi
