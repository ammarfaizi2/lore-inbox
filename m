Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285121AbRLMTtB>; Thu, 13 Dec 2001 14:49:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285133AbRLMTsv>; Thu, 13 Dec 2001 14:48:51 -0500
Received: from service.sh.cvut.cz ([147.32.127.214]:23305 "HELO
	service.sh.cvut.cz") by vger.kernel.org with SMTP
	id <S285126AbRLMTsc>; Thu, 13 Dec 2001 14:48:32 -0500
Date: Thu, 13 Dec 2001 20:48:28 +0100
From: Jan Janak <J.Janak@sh.cvut.cz>
To: Russell King <rmk@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: User/kernelspace stuff to set/get kernel variables
Message-ID: <20011213204828.A21032@devitka.sh.cvut.cz>
In-Reply-To: <20011213155532Z284289-18284+114@vger.kernel.org> <20011213172037.B22634@devitka.sh.cvut.cz> <20011213165805.F8007@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20011213165805.F8007@flint.arm.linux.org.uk>; from rmk@arm.linux.org.uk on Thu, Dec 13, 2001 at 04:58:05PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 13, 2001 at 04:58:05PM +0000, Russell King wrote:
> On Thu, Dec 13, 2001 at 05:20:37PM +0100, Jan Janak wrote:
> > If you pass a parameter that is not recognized by the kernel, it will be
> > passed to init as environment variable, so all you need to do is check
> > for the variable in your init scripts ($network in your example).
> 
> IIRC, Red Hat scripts grab them from /proc/cmdline

  Only parameters of the form foo=bar will be set as environment variables (if not
recognized by the kernel).
  AFAIK Red Hat scripts grab parameters of different form from /proc/cmdline.

  But parameter of the form network=dhcp will be set as environment variable and
 this is IMHO the easiest way how to get the parameter value in startup scripts.

  regards, Jan.

> 
> --
> Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
>              http://www.arm.linux.org.uk/personal/aboutme.html
