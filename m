Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290736AbSA3XGK>; Wed, 30 Jan 2002 18:06:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290728AbSA3XFx>; Wed, 30 Jan 2002 18:05:53 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:15883 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S290725AbSA3XFj>; Wed, 30 Jan 2002 18:05:39 -0500
Date: Wed, 30 Jan 2002 23:05:32 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: James Simmons <jsimmons@transvirtual.com>
Cc: Robert Love <rml@tech9.net>, Alex Khripin <akhripin@mit.edu>,
        linux-kernel@vger.kernel.org
Subject: Re: BKL in tty code?
Message-ID: <20020130230532.I19292@flint.arm.linux.org.uk>
In-Reply-To: <20020130210127.H19292@flint.arm.linux.org.uk> <Pine.LNX.4.10.10201301457450.7609-100000@www.transvirtual.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10201301457450.7609-100000@www.transvirtual.com>; from jsimmons@transvirtual.com on Wed, Jan 30, 2002 at 02:58:29PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2002 at 02:58:29PM -0800, James Simmons wrote:
> All the locking should be moved to the upper tty layers. Why implement the
> wheel over and over agin for each type of tty device.

By that statement, I can see that you haven't really done any analysis of
the tty nor serial locking.  Its not a simple case of "just add a per tty
semaphore in the tty layer and everything will be fine".

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

