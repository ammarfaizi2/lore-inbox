Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263835AbUDVIdI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263835AbUDVIdI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 04:33:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263875AbUDVIdI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 04:33:08 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:15627 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263835AbUDVIdF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 04:33:05 -0400
Date: Thu, 22 Apr 2004 09:33:02 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Jason Cox <steel300@gentoo.org>
Cc: James Simmons <jsimmons@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: Change number of tty devices
Message-ID: <20040422093302.B19797@flint.arm.linux.org.uk>
Mail-Followup-To: Jason Cox <steel300@gentoo.org>,
	James Simmons <jsimmons@infradead.org>,
	linux-kernel@vger.kernel.org
References: <E1BFhPh-00027s-IL@smtp.gentoo.org> <Pine.LNX.4.44.0404212109580.10680-100000@phoenix.infradead.org> <E1BGTsk-0000va-Bx@smtp.gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <E1BGTsk-0000va-Bx@smtp.gentoo.org>; from steel300@gentoo.org on Thu, Apr 22, 2004 at 02:24:06AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 22, 2004 at 02:24:06AM +0000, Jason Cox wrote:
> > When the kernel supports multi-desktop systems we will have to deal
> > with the serial and VT issue. Most likely the serial tty drivers will
> > be given a different major number. 
> 
> Why isn't this done now?

It's a API change and requires a flag day "everyone update their
filesystem."  Especially in a stable kernel series.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
