Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262571AbUKMMAu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262571AbUKMMAu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Nov 2004 07:00:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262647AbUKMMAt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Nov 2004 07:00:49 -0500
Received: from smtp-out.hotpop.com ([38.113.3.71]:29837 "EHLO
	smtp-out.hotpop.com") by vger.kernel.org with ESMTP id S262571AbUKMMAp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Nov 2004 07:00:45 -0500
From: "Antonino A. Daplas" <adaplas@hotpop.com>
Reply-To: adaplas@pol.net
To: linux-fbdev-devel@lists.sourceforge.net, Guido Guenther <agx@sigxcpu.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [Linux-fbdev-devel] Re: [PATCH] fbdev: Fix IO access in rivafb
Date: Sat, 13 Nov 2004 20:00:30 +0800
User-Agent: KMail/1.5.4
Cc: Linus Torvalds <torvalds@osdl.org>, adaplas@pol.net,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
References: <200411080521.iA85LbG6025914@hera.kernel.org> <1100309972.20511.103.camel@gaston> <20041113112234.GA5523@bogon.ms20.nix>
In-Reply-To: <20041113112234.GA5523@bogon.ms20.nix>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411132000.31465.adaplas@hotpop.com>
X-HotPOP: -----------------------------------------------
                   Sent By HotPOP.com FREE Email
             Get your FREE POP email at www.HotPOP.com
          -----------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 13 November 2004 19:22, Guido Guenther wrote:
> On Sat, Nov 13, 2004 at 12:39:32PM +1100, Benjamin Herrenschmidt wrote:
> > On Fri, 2004-11-12 at 20:18 +0100, Guido Guenther wrote:
> In 2.6.10-rc1-mm5 {in,out}_8 and read/writeb are exactly identical, only
> __raw_{read,write}b is different. So you mean __raw_{read,write}b in the
> above? (no nitpicking, just want to be sure I understand this
> correctly).

Why not use in_be* and out_be* for __raw_read and raw_write?  If I
understand correctly, they also have barriers.  Or would that hurt
performance?

Tony


