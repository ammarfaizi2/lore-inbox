Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262608AbTI1Wti (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Sep 2003 18:49:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262609AbTI1Wti
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Sep 2003 18:49:38 -0400
Received: from vitelus.com ([64.81.243.207]:10722 "EHLO vitelus.com")
	by vger.kernel.org with ESMTP id S262608AbTI1Wth (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Sep 2003 18:49:37 -0400
Date: Sun, 28 Sep 2003 15:48:10 -0700
From: Aaron Lehmann <aaronl@vitelus.com>
To: Adam Radford <aradford@3WARE.com>
Cc: "'Nick Piggin'" <piggin@cyberone.com.au>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Complete I/O starvation with 3ware raid on 2.6
Message-ID: <20030928224810.GA7680@vitelus.com>
References: <A1964EDB64C8094DA12D2271C04B8126F8C68B@tabby>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A1964EDB64C8094DA12D2271C04B8126F8C68B@tabby>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 25, 2003 at 11:19:20AM -0700, Adam Radford wrote:
> You should set CONFIG_3W_XXXX_CMD_PER_LUN in your .config to 16 or 32.

Hmm, I tried this, but I learned the hard way that make oldconfig
destroys this line.

What's the right way to do this?
