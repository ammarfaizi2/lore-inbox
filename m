Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265136AbTGHG1j (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 02:27:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266799AbTGHG1j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 02:27:39 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:28820 "EHLO
	imladris.demon.co.uk") by vger.kernel.org with ESMTP
	id S265136AbTGHG1i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 02:27:38 -0400
Subject: Re: JFFS2: many compile warnings with gcc 2.95 + kernel 2.5
From: David Woodhouse <dwmw2@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Adrian Bunk <bunk@fs.tum.de>, jffs-dev@axis.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <20030707180023.0877085e.akpm@osdl.org>
References: <20030708001937.GA6848@fs.tum.de>
	 <20030707180023.0877085e.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1057646526.28965.4.camel@imladris.demon.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.1 (dwmw2) 
Date: Tue, 08 Jul 2003 07:42:06 +0100
Content-Transfer-Encoding: 7bit
X-SA-Exim-Rcpt-To: akpm@osdl.org, bunk@fs.tum.de, jffs-dev@axis.com, linux-kernel@vger.kernel.org
X-SA-Exim-Scanned: No; SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-07-08 at 02:00, Andrew Morton wrote:
> Switching to %Z will fix that up.

Please don't. 

If you really can't ignore the cosmetic warnings, then either use a
C99-compliant compiler or remove the printf attribute from printk's
declaration in linux/kernel.h.


-- 
dwmw2


