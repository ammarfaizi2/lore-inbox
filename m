Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261463AbUC1MSi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Mar 2004 07:18:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261568AbUC1MSi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Mar 2004 07:18:38 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:62985 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S261463AbUC1MSg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Mar 2004 07:18:36 -0500
Date: Sun, 28 Mar 2004 14:18:31 +0200
From: Willy TARREAU <willy@w.ods.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org, mdharm-usb@one-eyed-alien.net
Subject: Re: [PATCH-2.4.26] sddr09 cleanup
Message-ID: <20040328121831.GA3957@pcw.home.local>
References: <20040328042608.GA17969@logos.cnet> <20040328121552.GD24421@pcw.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040328121552.GD24421@pcw.home.local>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 28, 2004 at 02:15:52PM +0200, Willy TARREAU wrote:
> Hi Marcelo,
> 
> sddr09 prints a warning about print_heap() which is not used.
> I ifdef'ed it out so that is still is usable for debugging
> purposes.

Sorry, I confused it with radeon_mem (which comes next).
For sddr09, it was sddr09_request_sense() which was not used
(only referenced in an ifdef'ed out function). Patch is correct
anyway.

Cheers,
Willy

