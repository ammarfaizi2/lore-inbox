Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262245AbVBQGfn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262245AbVBQGfn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 01:35:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262242AbVBQGfm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 01:35:42 -0500
Received: from colin2.muc.de ([193.149.48.15]:6668 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S262241AbVBQGfh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 01:35:37 -0500
Date: 17 Feb 2005 07:35:35 +0100
Date: Thu, 17 Feb 2005 07:35:35 +0100
From: Andi Kleen <ak@muc.de>
To: YhLu <YhLu@tyan.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: interrupt
Message-ID: <20050217063535.GB21305@muc.de>
References: <3174569B9743D511922F00A0C94314230808598B@TYANWEB>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3174569B9743D511922F00A0C94314230808598B@TYANWEB>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 16, 2005 at 10:47:07PM -0800, YhLu wrote:
> Interrupts always go to CPU 11.

Run irqbalanced, but even then multiple CPUs
will only be used when there are enough active interrupt sources.

-Andi
