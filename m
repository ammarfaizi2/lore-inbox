Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264137AbTL2Uy2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 15:54:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264292AbTL2Uy2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 15:54:28 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:10502 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S264137AbTL2Uy0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 15:54:26 -0500
Date: Mon, 29 Dec 2003 20:54:22 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Ryan Lackey <ryan@venona.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: cisco airo problem on apm reinsert w/ 2.6.0-*
Message-ID: <20031229205422.D30785@flint.arm.linux.org.uk>
Mail-Followup-To: Ryan Lackey <ryan@venona.com>,
	linux-kernel@vger.kernel.org
References: <20031229190636.GA2100@metacolo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20031229190636.GA2100@metacolo.com>; from ryan@venona.com on Mon, Dec 29, 2003 at 07:06:36PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 29, 2003 at 07:06:36PM +0000, Ryan Lackey wrote:
> Since at least 2.6.0-test7, I've had problems when re-inserting my cisco
> airo 340 pc card after sleeping the system.  It doesn't happen 100% of
> the time, but happens about 90% of the time -- I haven't figured out a
> pattern yet.  Once this happens, I have to reboot before the card will
> work again.

I think a patch appeared on lkml a while ago which fixes this problem,
but I'm unsure what the end result was.  It's caused by the airo module
trying to second-guess the kernels behaviour and coming out with the
wrong answer.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
