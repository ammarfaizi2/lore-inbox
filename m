Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268168AbUHFQqt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268168AbUHFQqt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 12:46:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268185AbUHFQk7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 12:40:59 -0400
Received: from [213.146.154.40] ([213.146.154.40]:45732 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S265732AbUHFQif (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 12:38:35 -0400
Subject: Re: [PATCH] Re-implemented i586 asm AES (updated)
From: David Woodhouse <dwmw2@infradead.org>
To: James Morris <jmorris@redhat.com>
Cc: Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org, torvalds@osdl.org
In-Reply-To: <Xine.LNX.4.44.0408061216210.22965-100000@dhcp83-76.boston.redhat.com>
References: <Xine.LNX.4.44.0408061216210.22965-100000@dhcp83-76.boston.redhat.com>
Content-Type: text/plain
Message-Id: <1091810308.4383.4916.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.dwmw2.1) 
Date: Fri, 06 Aug 2004 17:38:28 +0100
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-08-06 at 12:17 -0400, James Morris wrote:
> On Fri, 6 Aug 2004, Andi Kleen wrote:
> 
> > You could use .altinstructions to patch a jump in at runtime
> > based on CPU capabilities. Assuming MMX is really faster of course.
> 
> Neat.  The latter could be measured at boot.

On first use, please. Don't slow the boot down.

-- 
dwmw2

