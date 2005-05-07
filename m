Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263012AbVEGL0k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263012AbVEGL0k (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 May 2005 07:26:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263013AbVEGL0k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 May 2005 07:26:40 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:2829 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263012AbVEGL0i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 May 2005 07:26:38 -0400
Date: Sat, 7 May 2005 12:26:22 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Jan Dittmer <jdittmer@ppp0.net>, vince@kyllikki.org
Cc: Andrew Morton <akpm@osdl.org>, davej@redhat.com, torvalds@osdl.org,
       jgarzik@pobox.com, linux-kernel@vger.kernel.org
Subject: Re: RFD: Kernel release numbering
Message-ID: <20050507122622.C11839@flint.arm.linux.org.uk>
Mail-Followup-To: Jan Dittmer <jdittmer@ppp0.net>, vince@kyllikki.org,
	Andrew Morton <akpm@osdl.org>, davej@redhat.com, torvalds@osdl.org,
	jgarzik@pobox.com, linux-kernel@vger.kernel.org
References: <20050302230634.A29815@flint.arm.linux.org.uk> <42265023.20804@pobox.com> <Pine.LNX.4.58.0503021553140.25732@ppc970.osdl.org> <20050303002733.GH10124@redhat.com> <20050302203812.092f80a0.akpm@osdl.org> <20050304105247.B3932@flint.arm.linux.org.uk> <20050304032632.0a729d11.akpm@osdl.org> <20050304113626.E3932@flint.arm.linux.org.uk> <20050506235842.A23651@flint.arm.linux.org.uk> <427C9DBD.1030905@ppp0.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <427C9DBD.1030905@ppp0.net>; from jdittmer@ppp0.net on Sat, May 07, 2005 at 12:51:41PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 07, 2005 at 12:51:41PM +0200, Jan Dittmer wrote:
> Sorry for tapping in so late. I don't follow lkml that close. For some time
> I thought about providing semi-automatic mails of what architectures broke/
> got fixed from one version to another, tracking mm/rc/git(?). Would that
> be useful?

We have http://armlinux.simtec.co.uk/kautobuild/ setup for ARM -
it would be nice if it could generate mail reports and send them
out, especially when failures occur.

I think it would need some post-processing and rate limiting to
determine if there is a common problem across multiple platforms
(eg, 40 builds failing due to rd_size), or just one platform (some
local breakage).

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
