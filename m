Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263437AbRFAJhs>; Fri, 1 Jun 2001 05:37:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263435AbRFAJhi>; Fri, 1 Jun 2001 05:37:38 -0400
Received: from mandrakesoft.mandrakesoft.com ([216.71.84.35]:31548 "EHLO
	mandrakesoft.mandrakesoft.com") by vger.kernel.org with ESMTP
	id <S263434AbRFAJha>; Fri, 1 Jun 2001 05:37:30 -0400
Date: Fri, 1 Jun 2001 04:37:22 -0500 (CDT)
From: Jeff Garzik <jgarzik@mandrakesoft.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Mischke <thomas.mischke@isg.de>
Subject: Re: PATCH: tulip net driver update
In-Reply-To: <3B175F1E.D7584605@mandrakesoft.com>
Message-ID: <Pine.LNX.3.96.1010601043644.3545A-100000@mandrakesoft.mandrakesoft.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Jun 2001, Jeff Garzik wrote:
> tulip needs a small delay during rxtx restart.  different optimization
> patterns in newer gccs served to expose this bug which was previously
> hidden, so random users might hit a lack-of-networking depending on the
> speed of their machine, their compiler, etc.

Grrr, hold off on applying, it needs a further update as reported by
one test user.


