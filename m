Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267352AbUIOUJN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267352AbUIOUJN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 16:09:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267370AbUIOUJM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 16:09:12 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:23306 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S267352AbUIOUHy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 16:07:54 -0400
Date: Wed, 15 Sep 2004 21:07:49 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Roland Dreier <roland@topspin.com>,
       =?iso-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Being more anal about iospace accesses..
Message-ID: <20040915210749.A31396@flint.arm.linux.org.uk>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Roland Dreier <roland@topspin.com>,
	=?iso-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.58.0409081543320.5912@ppc970.osdl.org> <Pine.LNX.4.58.0409150737260.2333@ppc970.osdl.org> <Pine.LNX.4.58.0409150859100.2333@ppc970.osdl.org> <20040915165450.GD6158@wohnheim.fh-wedel.de> <524qlzxxka.fsf@topspin.com> <Pine.LNX.4.58.0409151024510.2333@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.58.0409151024510.2333@ppc970.osdl.org>; from torvalds@osdl.org on Wed, Sep 15, 2004 at 10:39:02AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 15, 2004 at 10:39:02AM -0700, Linus Torvalds wrote:
> In other words, think of "void *" as a pointer to storage. Not "char"  
> (which is the C name for a signed byte),

Common Programming Error #99: "char" is implementation whether it is
signed or may be unsigned.  Only a "char" type qualified by "signed"
or "unsigned" can be relied upon to have the requested property.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
