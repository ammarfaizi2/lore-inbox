Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261689AbSLOPD1>; Sun, 15 Dec 2002 10:03:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261701AbSLOPD1>; Sun, 15 Dec 2002 10:03:27 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:3590 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261689AbSLOPD0>; Sun, 15 Dec 2002 10:03:26 -0500
Date: Sun, 15 Dec 2002 15:11:15 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: How to do -nostdinc?
Message-ID: <20021215151115.B6486@flint.arm.linux.org.uk>
Mail-Followup-To: Keith Owens <kaos@ocs.com.au>,
	linux-kernel@vger.kernel.org
References: <1357.1039954001@ocs3.intra.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1357.1039954001@ocs3.intra.ocs.com.au>; from kaos@ocs.com.au on Sun, Dec 15, 2002 at 11:06:41PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 15, 2002 at 11:06:41PM +1100, Keith Owens wrote:
> The second format is simpler but there have been reports that it does
> not work with some versions of gcc.  I have been unable to find a
> definitive statement about which versions of gcc fail and whether the
> problem has been fixed.  Anybody care to provide a definitive
> statement?

When the problem appeared, it turned out to be an incorrectly configured
and/or built gcc installation.  (therefore, by definition,  not a kernel
problem.)

I believe the reporter of the problem subsequently fixed his compiler
installation.

I do, however, think we need to lobby the gcc people to get the
"depreciated" status of -iwithprefix reversed - it is a simple solution
to an otherwise disgusting amount of grep/awk/sed.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

