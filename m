Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261486AbTBQBbN>; Sun, 16 Feb 2003 20:31:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261689AbTBQBbN>; Sun, 16 Feb 2003 20:31:13 -0500
Received: from tapu.f00f.org ([202.49.232.129]:27533 "EHLO tapu.f00f.org")
	by vger.kernel.org with ESMTP id <S261486AbTBQBbM>;
	Sun, 16 Feb 2003 20:31:12 -0500
Date: Sun, 16 Feb 2003 17:41:11 -0800
From: Chris Wedgwood <cw@f00f.org>
To: Mark J Roberts <mjr@znex.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Annoying /proc/net/dev rollovers.
Message-ID: <20030217014111.GA2244@f00f.org>
References: <20030216221616.GA246@znex>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030216221616.GA246@znex>
User-Agent: Mutt/1.3.28i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 16, 2003 at 04:16:16PM -0600, Mark J Roberts wrote:

> The rolling-over of /proc/net/dev fields annoys me.

Why?

How often does it happen?

> total_rx_bytes += rx_bytes;

if lval is 64-bit, then this cannot be done reliably on all
architectures



  --cw
