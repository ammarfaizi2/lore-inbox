Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261365AbUK0Xjz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261365AbUK0Xjz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Nov 2004 18:39:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261366AbUK0Xjz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Nov 2004 18:39:55 -0500
Received: from serenity.mcc.ac.uk ([130.88.200.93]:29192 "EHLO
	serenity.mcc.ac.uk") by vger.kernel.org with ESMTP id S261365AbUK0Xjy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Nov 2004 18:39:54 -0500
Date: Sat, 27 Nov 2004 23:39:52 +0000
From: John Levon <levon@movementarian.org>
To: Pekka Enberg <penberg@cs.helsinki.fi>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Document kfree and vfree NULL usage
Message-ID: <20041127233952.GA5891@compsoc.man.ac.uk>
References: <1101565560.9988.20.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1101565560.9988.20.camel@localhost>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Graham Coxon - Happiness in Magazines
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *1CYCAS-000GZv-Sj*Pv7aHRx8tvE*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 27, 2004 at 04:26:00PM +0200, Pekka Enberg wrote:

> This patch adds comments for kfree() and vfree() stating that both accept
> NULL pointers.  I audited vfree() callers and there seems to be lots of
> confusion over this in the kernel.

Erm, are you sure about this? Somebody had to patch OProfile because
vfree() didn't like NULL value being passed in. When did this change?

john
