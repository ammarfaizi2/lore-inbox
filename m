Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272919AbTHKSsK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 14:48:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272963AbTHKSsC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 14:48:02 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:9426 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S272960AbTHKSr0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 14:47:26 -0400
Date: Mon, 11 Aug 2003 19:46:50 +0100
From: Dave Jones <davej@redhat.com>
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
Cc: Valdis.Kletnieks@vt.edu, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       jgarzik@pobox.com
Subject: Re: [PATCH] Remove useless assertions from reiserfs
Message-ID: <20030811184650.GC3884@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Petr Vandrovec <VANDROVE@vc.cvut.cz>, Valdis.Kletnieks@vt.edu,
	torvalds@osdl.org, linux-kernel@vger.kernel.org, jgarzik@pobox.com
References: <9D9C5DC650E@vcnet.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9D9C5DC650E@vcnet.vc.cvut.cz>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 11, 2003 at 08:33:13PM +0200, Petr Vandrovec wrote:

 > I always thought that assertions are just for that - if you can hit them
 > without some unexpected event/bug, you have a SERIOUS problem.

Not for when you explicitly code things above so it really cannot
happen. An assertion is more for the case "I really hope someone
doesn't pass me x in state y" type assertions than "I really hope
the compiler did the right thing with the previous loop"

		Dave

-- 
 Dave Jones     http://www.codemonkey.org.uk
