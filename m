Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262403AbTFORDT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 13:03:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262413AbTFORDT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 13:03:19 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:60683 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262403AbTFORDO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 13:03:14 -0400
Date: Sun, 15 Jun 2003 18:17:03 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: bad: scheduling while atomic!
Message-ID: <20030615181703.H5417@flint.arm.linux.org.uk>
Mail-Followup-To: David Woodhouse <dwmw2@infradead.org>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
References: <20030615142950.A32102@flint.arm.linux.org.uk> <1055697278.1244.19.camel@lapdancer.baythorne.internal>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1055697278.1244.19.camel@lapdancer.baythorne.internal>; from dwmw2@infradead.org on Sun, Jun 15, 2003 at 06:14:38PM +0100
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 15, 2003 at 06:14:38PM +0100, David Woodhouse wrote:
> On Sun, 2003-06-15 at 14:29, Russell King wrote:
> > It would be useful if we could balance the spin_locks with the
> > spin_unlocks. 8)
> 
> I can see how that could be considered appropriate. There are a handful
> of other such trivia in CVS which want to go to Linus shortly -- I
> assume that includes your afs partitioning fix?

Yes, although I was considering sending that one myself.  If you're due
to do another sync up, feel free to include that.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

