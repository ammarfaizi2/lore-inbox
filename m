Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282914AbRLQWFQ>; Mon, 17 Dec 2001 17:05:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282902AbRLQWFG>; Mon, 17 Dec 2001 17:05:06 -0500
Received: from www.deepbluesolutions.co.uk ([212.18.232.186]:26896 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S282898AbRLQWEz>; Mon, 17 Dec 2001 17:04:55 -0500
Date: Mon, 17 Dec 2001 22:04:02 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Thomas Hood <jdthood@mail.com>
Cc: sfr@canb.auug.org.au, linux-kernel@vger.kernel.org
Subject: Re: APM driver patch summary
Message-ID: <20011217220402.A6418@flint.arm.linux.org.uk>
In-Reply-To: <1008613695.4859.84.camel@thanatos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1008613695.4859.84.camel@thanatos>; from jdthood@mail.com on Mon, Dec 17, 2001 at 01:28:13PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 17, 2001 at 01:28:13PM -0500, Thomas Hood wrote:
> Each of these changes is required, IMHO.  However, the Russell King
> patch probably won't apply without modifications.  Also, it needs to
> be modified so that it will send a resume event to listeners in case
> a driver rejects a suspend event that listeners have already
> processed.

It does do that - check the suspend() function.

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

