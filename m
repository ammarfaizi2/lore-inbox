Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311839AbSEHIOz>; Wed, 8 May 2002 04:14:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311884AbSEHIOy>; Wed, 8 May 2002 04:14:54 -0400
Received: from www.deepbluesolutions.co.uk ([212.18.232.186]:53000 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S311839AbSEHIOy>; Wed, 8 May 2002 04:14:54 -0400
Date: Wed, 8 May 2002 09:14:42 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
Cc: Patrick Mochel <mochel@osdl.org>,
        Thunder from the hill <thunder@ngforever.de>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.14 IDE 56
Message-ID: <20020508091442.A16868@flint.arm.linux.org.uk>
In-Reply-To: <Pine.LNX.4.44.0205071245370.4189-100000@hawkeye.luckynet.adm> <Pine.LNX.4.33.0205071238000.6307-100000@segfault.osdl.org> <200205072203.g47M3o002102@vindaloo.ras.ucalgary.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 07, 2002 at 04:03:50PM -0600, Richard Gooch wrote:
> But it's not actually broken, now that the locking is fixed.

Really?  What about the case of the missing BKL for device opens that
you haven't really commented on?

Seems like devfs _still_ has locking problems.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

