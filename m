Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284359AbRLMQ6o>; Thu, 13 Dec 2001 11:58:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284361AbRLMQ6e>; Thu, 13 Dec 2001 11:58:34 -0500
Received: from www.deepbluesolutions.co.uk ([212.18.232.186]:44548 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S284359AbRLMQ6V>; Thu, 13 Dec 2001 11:58:21 -0500
Date: Thu, 13 Dec 2001 16:58:05 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Jan Janak <J.Janak@sh.cvut.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: User/kernelspace stuff to set/get kernel variables
Message-ID: <20011213165805.F8007@flint.arm.linux.org.uk>
In-Reply-To: <20011213155532Z284289-18284+114@vger.kernel.org> <20011213172037.B22634@devitka.sh.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011213172037.B22634@devitka.sh.cvut.cz>; from J.Janak@sh.cvut.cz on Thu, Dec 13, 2001 at 05:20:37PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 13, 2001 at 05:20:37PM +0100, Jan Janak wrote:
> If you pass a parameter that is not recognized by the kernel, it will be
> passed to init as environment variable, so all you need to do is check
> for the variable in your init scripts ($network in your example).

IIRC, Red Hat scripts grab them from /proc/cmdline

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

