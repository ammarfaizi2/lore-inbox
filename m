Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262429AbTFORBZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 13:01:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262430AbTFORBY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 13:01:24 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:13440 "EHLO
	lapdancer.baythorne.internal") by vger.kernel.org with ESMTP
	id S262429AbTFORBS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 13:01:18 -0400
Subject: Re: bad: scheduling while atomic!
From: David Woodhouse <dwmw2@infradead.org>
To: Russell King <rmk@arm.linux.org.uk>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030615142950.A32102@flint.arm.linux.org.uk>
References: <20030615142950.A32102@flint.arm.linux.org.uk>
Content-Type: text/plain
Organization: 
Message-Id: <1055697278.1244.19.camel@lapdancer.baythorne.internal>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5.dwmw2) 
Date: Sun, 15 Jun 2003 18:14:38 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-06-15 at 14:29, Russell King wrote:
> It would be useful if we could balance the spin_locks with the
> spin_unlocks. 8)

I can see how that could be considered appropriate. There are a handful
of other such trivia in CVS which want to go to Linus shortly -- I
assume that includes your afs partitioning fix?

-- 
dwmw2


