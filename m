Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261569AbUKGKOp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261569AbUKGKOp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Nov 2004 05:14:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261571AbUKGKOp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Nov 2004 05:14:45 -0500
Received: from cantor.suse.de ([195.135.220.2]:54163 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261570AbUKGKOi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Nov 2004 05:14:38 -0500
Date: Sun, 7 Nov 2004 11:14:35 +0100
From: Andi Kleen <ak@suse.de>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@suse.de>
Subject: Re: [PATCH] panic_blink and i8042 unloading
Message-ID: <20041107101435.GA2752@wotan.suse.de>
References: <200411070134.31775.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200411070134.31775.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 07, 2004 at 01:34:31AM -0500, Dmitry Torokhov wrote:
> Hi,
> 
> At unload i8042 sets panic_blink to 0. This will cause problems if kernel
> panics later as it will just use it assuming that the pointer is correct.
> 
> Please consider the patch below that checks if panic_blink is NULL right
> in panic() and sets it to no_blink instead.

Thanks, looks good.

-Andi
